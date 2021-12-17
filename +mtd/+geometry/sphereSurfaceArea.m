function sa = sphereSurfaceArea(radius)
%SPHERESURFACEAREA compute the surface area of the sphere
%
%   You're the kind of person that also read the sphereVolume documentation, huh?
%
%   [SA] = SPHERESURFACEAREA(RADIUS) compute the surface area of the sphere with given 
%   radius value. RADIUS can be a vector of radii. It is validated to be positive.
%
%   See also: mtd.geometry.sphereVolume, mtd.geometry.ellipsoidVolume
arguments
    radius double {mustBePositive}
end

sa = 4 .* pi .* radius.^2;

end