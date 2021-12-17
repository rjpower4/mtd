function r = computePrimaryDistance(sma, ecc, ta)
arguments
    sma {mustBeNonzero}
    ecc {mustBeNonnegative}
    ta
end

p = mtd.tbp.computeParameter(sma, ecc);
r = p ./ (1 + ecc .* cos(ta));

end