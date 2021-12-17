function v = computeCircularVelocity(gm, r)
%COMPUTECIRCULARVELOCITY calculate the circular orbital velocity for an orbit of radius R
%around a body with gravitational parameter GM
arguments
    gm double {mustBePositive}
    r double {mustBePositive}
end

v = sqrt(gm ./ r);

end