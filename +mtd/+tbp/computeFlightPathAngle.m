function fpa = computeFlightPathAngle(sma, ecc, ta)
    arguments
        sma {mustBeNonzero}
        ecc {mustBeNonnegative}
        ta
    end
    r = mtd.tbp.computePrimaryDistance(sma, ecc, ta);
    fpa = acos(sqrt(sma.^2 .* (1 - ecc.^2) ./ (r .* (2 .* sma - r))));
end