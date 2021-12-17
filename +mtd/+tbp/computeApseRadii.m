function [rp, ra] = computeApseRadii(sma, ecc)
    %COMPUTEAPSERADII compute the periapsis and apoapsis radii from the semi-major axis
    %and the eccentricity
    arguments
        sma {mustBeNonzero}
        ecc {mustBeNonnegative}
    end
    valid = mtd.tbp.validOrbitShapePair(sma, ecc);
    if any(~valid)
        error("Invalid orbit shape pair.");
    end

    % We have to set the apoapsis radii to infinity for any open orbit by definition
    closed = mtd.tbp.isClosed(ecc);
    ra = zeros(size(sma));
    rp = sma .* (1 - ecc);
    ra(closed) = sma(closed) .* (1 + ecc(closed));
    ra(~closed) = Inf;
end