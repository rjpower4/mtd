function inertia = ellipsoidInertiaTensor(semiAxes, mass)
%ELLIPSOIDINERTIATENSOR compute the inertia tensor of the ellipsoid with defined semi-axis
%lengths
%
%   The returned 3x3 tensors are such that the nth row/column corresponds to the axis
%   associated with the nth semi-axis length.
%
%   [INERTIA] = ELLIPSOIDINERTIATENSOR(SEMIAXES) returns the inertia tensors for the
%   semi-axis lengths SEMIAXES assuming unity mass; this effectively provides the
%   "specific" inertia tensor. The semi-axis lengths are the columns of SEMIAXES with each
%   ellipsoid as a different row. The inertia tensors are returned in INERTIA with each
%   page of the 3x3xN matrix corresponding to a row of SEMIAXES.
%
%   [INERTIA] = ELLIPSOIDINERTIATENSOR(SEMIAXES, MASS) is the same as the single parameter
%   call but with non-negative mass MASS.
arguments
    semiAxes (:, 3) double {mustBePositive}
    mass (:, 1) double {mustBePositive} = 1;
end

% Compute so that we can ensure that mass in congruent and we can allocate output space
nAxes = size(semiAxes, 1);
nMasses = size(mass, 1);
if nMasses ~= 1 && nMasses ~= nAxes
    error("Incompatible number of semi-axes (%d) and masses (%d)", nAxes, nMasses)
end

inertia = zeros(3, 3, nAxes);
squares = semiAxes.^2;
inertia(1, 1, :) = mass ./ 5 .* (squares(:, 2) + squares(:, 3));
inertia(2, 2, :) = mass ./ 5 .* (squares(:, 1) + squares(:, 3));
inertia(3, 3, :) = mass ./ 5 .* (squares(:, 1) + squares(:, 2));
end