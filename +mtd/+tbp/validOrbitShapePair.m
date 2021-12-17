function t = validOrbitShapePair(sma, ecc)
    %VALIDORBITSHAPEPAIR determine if the given semi-major axis and eccentricity form a
    %valid pair
    arguments
        sma {mustBeNonzero}
        ecc {mustBeNonnegative}
    end
    closed = mtd.tbp.isClosed(ecc);
    t = false(size(sma));
    t(closed) = sma(closed) > 0;
    t(~closed) = sma(~closed) < 0;
end