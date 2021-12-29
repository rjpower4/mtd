function [eqPoints, didConverge] = computeCollinearEquilibria(massRatio, ax, options)
%COMPUTECOLLINEAREQUILIBRIA calculate the collinear equilibrium solutions in Cox's
%problem
%
%   The collinear equilibra are those equilibrium solutions that exist on the x-axis
%   as defined in the standard CRTBP rotating frame. In Cox's model, these only exist
%   when the low-thrust acceleration is oriented parallel (or anti-parallel) to the
%   x-axis. Consequently, the `ax` parameter passed to this function is a scalar with
%   positive numbers corrensponding to dot(a, x) > 0 and negative corresponding to the
%   opposite, i.e., dot(a, x) < 0 where a is the full 3 vector for the low-thrust
%   acceleration.
%
%   [EQPOINTS] = COMPUTECOLLINEAREQUILIBRIA(MASSRATIO, AX) compute the collinear
%   equilibrium points for the system with CRTBP mass ratio MASSRATIO and low-thrust
%   acceleration AX. The returned array is a 3x6 matrix with each row representing a
%   collinear equilibrium state.
%
%   [EQPOINTS, DID_CONVERGE] = COMPUTECOLLINEAREQUILIBRIA(...) compute as above but also
%   return a matrix a Nx3 logical matrix identifying which equilibrium point solutions did
%   converge.
arguments
    massRatio {mtd.crtbp.mustBeAValidMassRatio}
    ax double {mustBeVector}
    options.tol double {mtd.util.mustBeValidTolerance} = 1e-12
    options.maxiter {mustBeInteger, mustBeGreaterThan(options.maxiter, 1)} = 15
end

eqPoints = zeros(3, 6, length(ax));
didConverge = false(length(eqPoints), 3);

for k = 1:length(ax)
    % Fast path for CRTBP (a = 0) as these are just the lagrange points
    if ax(k) == 0
        lagrangePoints = crtbpLagrangePoints(massRatio);
        eqPoints(:, :, k) = lagrangePoints(1:3, :);
        didConverge(k, :) = [true, true, true];
    else
        [eqPoints(:, :, k), didConverge(k, :)] = internalSolver(massRatio, ax(k), options);
    end
end

end

function [q, didConverge] = internalSolver(mu, ax, options)
% Determine gamma values
[guess1, guess2, guess3] = generateInitialGuesses(mu);
[g1, dc1] = simpleNewtonRaphson(@(x) fdf1(mu, ax, x), guess1, options);
[g2, dc2] = simpleNewtonRaphson(@(x) fdf2(mu, ax, x), guess2, options);
[g3, dc3] = simpleNewtonRaphson(@(x) fdf3(mu, ax, x), guess3, options);

[x1, x2, x3] = g2x(mu, g1, g2, g3);
q = [x1, 0, 0, 0, 0, 0;
    x2, 0, 0, 0, 0, 0;
    x3, 0, 0, 0, 0, 0];

if nargout > 1
    didConverge = [dc1; dc2; dc3];
end

end

function [g1, g2, g3] = x2g(mu, x1, x2, x3)
%X2G convert the x coordinates to their respective gamma values
g1 = 1 - mu - x1;
g2 = x2 - 1 + mu;
g3 = -mu - x3;
end

function [x1, x2, x3] = g2x(mu, g1, g2, g3)
%G2X convert gamma coordinates to their respective x values
x1 = 1 - mu - g1;
x2 = 1 - mu + g2;
x3 = -mu - g3;
end

function [g1, g2, g3] = generateInitialGuesses(mu)
%GENERATEINITIALGUESSES generate initial guesses for the collinear equilibrium points
%
%   For this initial guess, I am just using the location of the Lagrange points, i.e., the
%   location of the equilibrium solutions with no low-thrust acceleration present.
lagrangePoints = mtd.crtbp.computeLagrangePoints(mu);
[g1, g2, g3] = x2g(mu, lagrangePoints(1,1), lagrangePoints(2,1), lagrangePoints(3,1));
end

function [f, df] = fdf1(mu, a, g)
%FDF1 helper function to evaluate function and derivative for x1 equilibrium solution
f = 1 - mu - g - (1 - mu) / (1 - g)^2 + mu / g^2 + a;
df = -1 - 2 * (1 - mu) / (1 - g)^3 - 2 * mu / g^3;
end

function [f, df] = fdf2(mu, a, g)
%FDF2 helper function to evaluate function and derivative for x1 equilibrium solution
f = (1 - mu) / (1 + g)^2 + mu / g^2 - 1 + mu - g - a;
df = -2 * (1 - mu) / (1 + g)^3 - 2 * mu / g^3 - 1;
end

function [f, df] = fdf3(mu, a, g)
%FDF3 helper function to evaluate function and derivative for x1 equilibrium solution
f = -mu - g + (1 - mu) / g^2 + mu / (g + 1)^2 + a;
df = -1 - 2*(1 - mu) / g^3 - 2 * mu / (g + 1)^3;
end

function [x, didConverge, nIter] = simpleNewtonRaphson(f, x0, options)
%SIMPLENEWTONRAPHSON simple newton raphson function to solve for root
x = x0;
[g, dg] = f(x);
nIter = 0;
while abs(g) > options.tol && nIter < options.maxiter
    x = x - g / dg;
    [g, dg] = f(x);
    nIter = nIter + 1;
end
didConverge = abs(g) <= options.tol;
end