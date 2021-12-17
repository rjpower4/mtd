function v = ellipsoidVolume(semiAxes)
%ELLIPSOIDVOLUME compute the volume of an ellipsoid given the lengths of the semi-axes.
arguments
    semiAxes (:, 3) double {mustBePositive}
end
v = (4/3) .* pi .* prod(semiAxes, 2);
end