function v = sphereVolume(radius)
%SPHEREVOLUME compute the volume of the sphere
%
%   Honestly, there's not a lot of magic here... Why are you still reading this
%   documentation?
%
%   [V] = SPHEREVOLUME(RADIUS) compute the volume(s) of the sphere(s) with given radius
%   value(s). RADIUS can be a vector of radii. It is validated to be positive.
arguments
    radius double {mustBePositive}
end

v = (4/3) .* pi .* radius.^3;

end