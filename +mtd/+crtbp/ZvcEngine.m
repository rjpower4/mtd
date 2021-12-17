classdef ZvcEngine
    properties
        tol double {mtd.util.mustBeValidTolerance} = 1e-12
        dx (1, 1) double = 5e-4
        dy (1, 1) double = 5e-4
        verbose (1, 1) logical = false
        minStepSize (1, 1) double = 1e-6
        slopeThreshold (1, 1) double = 1.5
        axisCrossTol (1, 1) {mtd.util.mustBeValidTolerance} = 1.5 * 1e-4
        maxiter (1, 1) {mustBeInteger} = 200
        maxPoints (1, 1) {mustBeInteger} = 2.5e5
    end

    methods
        function zvc = generate(this, massRatio, jacobiConstant, z)
            arguments
                this
                massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
                jacobiConstant (1, 1) double
                z (1, 1) double = 0
            end

            % Setup
            numIterations = 0;
            dxLocal = this.dx;
            dyLocal = this.dy;

            % Bounding Jacobi Values
            lagrangePoints = mtd.crtbp.computeLagrangePoints(massRatio);
            c2m = [0.025 + (1-massRatio), 0, 0, 0, 0, 0];  % close to moon
            jcP2 = mtd.crtbp.computeJacobiConstant(massRatio, c2m);
            jcLagrangePoints = mtd.crtbp.computeJacobiConstant(massRatio, lagrangePoints);
            jcL1 = jcLagrangePoints(1);
            jcL2 = jcLagrangePoints(2);
            jcL3 = jcLagrangePoints(3);
            jcL4 = jcLagrangePoints(4);

            % Determine Region
            region = -1;
            jcAdjusted = jacobiConstant + abs(z) + 1e-4; % value that assists with non-zero z
            if jcAdjusted >= jcP2
                region = 1;
            elseif jcAdjusted >= jcL1
                region = 2;
            elseif jcAdjusted >= jcL2
                region = 3;
            elseif jcAdjusted >= jcL3
                region = 4;
            elseif jcAdjusted > jcL4
                region = 5;
            end

            % Get the initial guess as a function of the region
            switch region
                case 1
                    xGuess = [-massRatio, -massRatio];
                    yGuess = [0.5, 1.5];
                    description = "Concentric circles about P1";
                case 2
                    xGuess = [-massRatio, -massRatio, 1-massRatio] * (1 - 1.5 * abs(z)^3);
                    yGuess = [0.5, 1.5, 0.05];
                    description = "Concentric circles about P1 and a circle around P2";
                case 3
                    xGuess = [-massRatio, -massRatio];
                    yGuess = [0.5, 1.5];
                    description = "Horseshoe with L2 closed";
                case 4
                    xGuess = -massRatio;
                    yGuess = 1.5;
                    description = "Horseshoe with L2 open";
                case 5
                    xGuess = lagrangePoints(4,1);
                    yGuess = lagrangePoints(4,2) + 0.2;

                    % Set the step size to the minimum of two choices: 5e-4 or the greater of
                    % 10*(JC-JC_L4) and 1e-6. This prevents too small of a step size.
                    dxLocal = min([5e-4, max(10*(jacobiConstant - jcL4), this.minStepSize)]);

                    % Also adjust axis crossing tolerance that is used to detect wrap-arounds in
                    % this region
                    this.axisCrossTol = 1.5 * dyLocal;

                    % Adjust dy as well
                    dyLocal = min([5e-4, max([10*(jacobiConstant - jcL4), this.minStepSize])]);


                    if options.verbose
                        fprintf("Adjusting dx to %1.4e\n", dxLocal);
                        fprintf("Adjusting dy to %1.4e\n", dyLocal);
                    end
                    description = "Tear drops around triangular points";

                otherwise
                    description = "No ZVCs at this energy level";
                    struct('points', [], ...
                        'numIterations', 0, ...
                        'description', description, ...
                        'region', region);
                    return
            end

            % Info on verbose
            if this.verbose
                fprintf("ZVC in Region %d: %s\n", region, description);
            end

            % Pre-Allocate the points array
            pts = zeros(20000, 4);

            %% Point Locating
            icNum = 1; % what guess we're on
            ptNum = 1; % what point we're on

            while icNum <= length(xGuess)
                if region <= 4
                    step = -2; % Allow algorithm to check both left and right from guess
                else
                    step = -3; % Only check dir = 1 (right, or +x)
                end

                for dir = 1:step:-1
                    % Find the first point
                    x = xGuess(icNum);
                    [y, iters, cv] = this.determineYValue(x, yGuess(icNum), z, jacobiConstant, massRatio);

                    if ~cv
                        warning("Failed Newton-Raphson iteration at x=%1.4e, y=%1.4e", x, y);
                    end

                    numIterations = numIterations + iters;
                    yGuess(icNum) = y;
                    slope = 0;
                    pts(ptNum, :) = [x, y, z, 1];
                    ptNum = ptNum + 1;

                    % deltaX is the change in x between the past two point.
                    deltaX = dir;

                    % Set exit condition to false and start
                    doneWithArc = false;

                    while ~doneWithArc
                        if abs(slope) < this.slopeThreshold
                            % Step in the X direction
                            x = x + dxLocal * sign(deltaX);

                            % Use NR to find new y
                            [y, iters, cv] = this.determineYValue(x, y, z, jacobiConstant, massRatio);
                            if ~cv
                                warning("Failed Newton-Raphson iteration at x=%1.4e, y=%1.4e", ...
                                    x, y);
                            end
                            numIterations = numIterations + iters;
                            pts(ptNum, :) = [x, y, z, 1];
                        else
                            % Step in y direction
                            y = y + dyLocal * sign(deltaY);
                            [x, iters, cv] = this.determineXValue(x, y, z, jacobiConstant, massRatio);
                            if ~cv
                                warning("Failed Newton-Raphson iteration at x=%1.4e, y=%1.4e", ...
                                    x, y);
                            end
                            numIterations = numIterations + iters;
                            pts(ptNum, :) = [x, y, z, 2];
                        end

                        % Compute changes in x and y from previous point
                        deltaX = pts(ptNum, 1) - pts(ptNum - 1, 1);
                        deltaY = pts(ptNum, 2) - pts(ptNum - 1, 2);
                        slope = deltaY / deltaX;

                        ptNum = ptNum + 1;

                        % Kill if too many points
                        if ptNum > this.maxPoints
                            break;
                        end

                        % Check Exit Conditions
                        if region <= 4
                            % Quit if we've reached an axis crossing (we'll mirror)
                            if abs(y) < this.axisCrossTol
                                doneWithArc = true;
                            end
                        else
                            % In this case the arc needs to loop back on itself
                            if ptNum > 10 && abs(pts(1,1) - x) < this.axisCrossTol && ...
                                    abs(pts(1,2) - y) < this.axisCrossTol
                                doneWithArc = true;
                            end
                        end

                        % Absolute exit conditions - limit number of poitns per arc and
                        % direction combo
                        if ptNum > (75/dxLocal) * icNum
                            doneWithArc = true;
                        end
                    end
                    if  ~isnan(pts(ptNum - 1, 1))
                        % Insert NaN so that plotting won't connect dots that shouldn't be
                        % connected
                        pts(ptNum,:) = [NaN,NaN,NaN,0];
                        ptNum = ptNum + 1;
                    end
                end

                % Try the next guess
                icNum = icNum + 1;

                if ~isnan(pts(ptNum - 1, 1))
                    % Insert NaN so that plotting won't connect dots that shouldn't be
                    % connected
                    pts(ptNum, :) = [NaN, NaN, NaN, 0];
                    ptNum = ptNum + 1;
                end
            end

            %% Output
            if this.verbose
                fprintf("Used %d points\n", ptNum)
                fprintf("Used %ld Newton-Raphson iterations\n", numIterations)
                fprintf("\tor %.2f iterations per point\n", numIterations / ptNum)
            end

            % Create array of the coordinates and concatenate the mirrored coordinates
            pointsShrunk = pts(1:ptNum-1, :);
            mirrorY = [1 0 0; 0 -1 0; 0 0 1];
            points = [pointsShrunk(:, 1:3); pointsShrunk(:, 1:3)*mirrorY];
            zvc = struct('points', points, ...
                'numIterations', numIterations, ...
                'description', description, ...
                'region', region);
        end
    end

    methods (Access = private)
        function [x, count, converged] = determineXValue(this, xGuess, y, z, jc, mu)
            %DETERMINEXVALUE compute the x-coordinate on ZVC using Newton-Raphson
            count = 0;

            previousX = -inf;
            x = xGuess;
            while abs(x - previousX) > this.tol && count < this.maxiter
                previousX = x;
                d1 = sqrt((x + mu)^2 + y^2 + z^2);
                d2 = sqrt((x - 1 + mu)^2 + y^2 + z^2);
                dfDx = -2 * (1 - mu) * (x + mu) / d1^3 - 2 * mu * (x + mu - 1) / d2^3 + 2 * x;
                f = 2 * (1 - mu) / d1 + 2 * mu / d2 + x^2 + y^2 - jc;
                x = previousX - f / dfDx;
                count = count + 1;
            end
            converged = count < this.maxiter;
        end

        function [y, count, converged] = determineYValue(this, x, yGuess, z, jc, mu)
            %DETERMINEYVALUE compute the y-coordinate on ZVC using Newton-Raphson
            count = 0;

            previousY = -inf;
            y = yGuess;
            while abs(y - previousY) > this.tol && count < this.maxiter
                previousY = y;
                d1 = sqrt((x + mu)^2 + y^2 + z^2);
                d2 = sqrt((x - 1 + mu)^2 + y^2 + z^2);
                dfDy = -2 * (1 - mu) * y / d1^3 - 2 * mu * y / d2^3 + 2 * y;
                f = 2 * (1 - mu) / d1 + 2 * mu / d2 + x^2 + y^2 - jc;
                y = previousY - f / dfDy;
                count = count + 1;
            end
            converged = count < this.maxiter;
        end
    end
end