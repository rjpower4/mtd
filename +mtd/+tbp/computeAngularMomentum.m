function h = computeAngularMomentum(gm, sma, ecc)
    arguments
        gm {mustBePositive}
        sma {mustBeNonzero}
        ecc {mustBeNonnegative}
    end
    p = mtd.tbp.computeParameter(sma, ecc);
    h = sqrt(gm .* p);
end