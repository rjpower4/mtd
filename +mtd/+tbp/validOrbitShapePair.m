function t = validOrbitShapePair(sma, ecc)
%VALIDORBITSHAPEPAIR determine if the given semi-major axis and eccentricity form a valid
%pair.
%
%   The purpose of this function is to determine if the given semi-major axis and
%   eccentricites form a valid pair. By valid pair, we mean that they conform to the sign
%   conventions used throughout this software.
%       
%   - Closed Orbits (Circular and Elliptical Orbits): a > 0 and 0 <= e <= 1
%   - Open Orbits
%       - Parabolic Orbits: a = Inf, e = 1
%       - Hyperbolic Orbits: a < 0, e > 1
%
%   Note that e must always be non-negative!
arguments
    sma {mustBeNonzero}
    ecc {mustBeNonnegative}
end
t = false(size(sma));
parabolicMask = mtd.tbp.isParabolic(ecc);
t(parabolicMask) = sma(parabolicMask) == Inf;
t(~parabolicMask) = ((ecc(~parabolicMask) - 1) .* sma(~parabolicMask)) < 0;
end