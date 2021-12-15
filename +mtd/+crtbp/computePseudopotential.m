function omega = computePseudopotential(massRatio, q)
    arguments
        massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
        q (:, 6) double
    end
    dists = mtd.crtbp.computePrimaryDistance(massRatio, q);
    omega = (1 - massRatio) ./ dists(:, 2) + massRatio ./ dists(:, 2) + 0.5 * (q(:, 1).^2 + q(:, 2).^2);
end