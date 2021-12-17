function t = isHyperbolic(ecc)
%ISELLIPTICAL return true if eccentricity is consistent with that of an hyperbolic orbit
t = ecc > 1;
end