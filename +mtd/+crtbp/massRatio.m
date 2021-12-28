function mu = massRatio(p1, p2)
%MASSRATIO compute the mass ratio of the two celestial bodies consistent with the
%definition for the CRTBP.
arguments
    p1 mtd.body.CelestialBody
    p2 mtd.body.CelestialBody
end

% Mass ratio defined as m2 / (m1 + m2)
gm1 = p1.gravitationalParameter;
gm2 = p2.gravitationalParameter;
mu = gm2 / (gm1 + gm2);

end