function lagrangePoints = computeLagrangePoints(massRatio, options)
    %COMPUTELAGRANGEPOINTS compute the equilibrium states in the CRTBP called the Lagrange
    %points
    %
    %   The calculation is performed via a simple Newton-Raphson solver
    arguments
        massRatio double {mustBeVector, mtd.crtbp.mustBeAValidMassRatio}
        options.tol double {mustBeInRange(options.tol, 0, 1, "exclusive")} = 1e-12
        options.maxiter {mustBeInteger, mustBeGreaterThan(options.maxiter, 1)} = 15
    end

    nMassRatios = length(massRatio);
    lagrangePoints = zeros(5, 6, nMassRatios);

    for k = 1:nMassRatios
        % Pull out this mass ratio
        mu = massRatio(k);

        % Calculate guesses for collinear point x values
        xCollinearGuess = szebehelyInitialGuesses(mu);

        % Convert the x guesses to the gamma values referenced from:
        %   1. Left of P2
        %   2. Right of P2
        %   3. Left of P1
        g1Guess = 1 - mu - xCollinearGuess(1);
        g2Guess = xCollinearGuess(2) - 1 + mu;
        g3Guess = -mu - xCollinearGuess(3);

        % Converge gammas
        g1 = newtonRaphson(@hPoint1, mu, g1Guess, options.tol, options.maxiter);
        g2 = newtonRaphson(@hPoint2, mu, g2Guess, options.tol, options.maxiter);
        g3 = newtonRaphson(@hPoint3, mu, g3Guess, options.tol, options.maxiter);

        % Convert to states
        lagrangePoints(1, 1, k) = 1 - mu - g1;
        lagrangePoints(2, 1, k) = 1 - mu + g2;
        lagrangePoints(3, 1, k) = 0 - mu - g3;
        lagrangePoints(4, 1, k) = 0.5 - mu;
        lagrangePoints(4, 2, k) = sqrt(3) / 2;
        lagrangePoints(5, 1, k) = lagrangePoints(4, 1);
        lagrangePoints(5, 2, k) = -lagrangePoints(4, 2);
    end
end

function x0 = szebehelyInitialGuesses(mu)
    %SZEBEHELYINITIALGUESSES get initial guesses for collinear point x values

    eta = (mu / 3)^(1 / 3);
    sigma = 7 * mu / 12;

    x0 = zeros(1, 3);
    x3Coefs = fliplr([1, 0, 23/84, 23/84, 761/2352, 3163/7056, 30703/49392]);

    x0(1) = 1 - mu - eta * polyval([-1/9,  151/243, -23/81, -1/9, -1/3, 1], eta);
    x0(2) = 1 - mu + eta * polyval([-1/9, -119/243, -31/81, -1/9,  1/3, 1], eta);
    x0(3) = -mu - 1 + sigma * polyval(x3Coefs, sigma);
end

function [f, df] = hPoint1(mu, g)
    f = 1 - mu - g - (1 - mu) / (1 - g)^2 + mu / g^2;
    df = -1 - 2 * (1 - mu) / (1 - g)^3 - 2 * mu / g^3;
end

function [f, df] = hPoint2(mu, g)
    f = (1 - mu) / (1 + g)^2 + mu / g^2 - 1 + mu - g;
    df = -2 * (1 - mu) / (1 + g)^3 - 2 * mu / g^3 - 1;
end

function [f, df] = hPoint3(mu, g)
    f = -mu - g + (1 - mu) / g^2 + mu / (g + 1)^2;
    df = -1 - 2*(1 - mu) / g^3 - 2 * mu / (g + 1)^3;
end

function g = newtonRaphson(helper, mu, g0, tolerance, maxIter)
    g = g0;
    [f, df] = helper(mu, g);
    iterCount = 0;
    while abs(f) > tolerance && iterCount < maxIter
        g = g - f / df;
        [f, df] = helper(mu, g);
        iterCount = iterCount + 1;
    end
    if iterCount == maxIter
        warning("Lagrange Point solver failed to converge under %d iterations", maxIter)
    end
end