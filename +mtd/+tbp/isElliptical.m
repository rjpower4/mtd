function t = isElliptical(ecc)
%ISELLIPTICAL return true if eccentricity is consistent with that of an elliptical orbit
t = (ecc < 1) & (ecc >= 0);
end