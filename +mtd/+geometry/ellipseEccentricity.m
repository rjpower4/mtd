function e = ellipseEccentricity(semiAxes)
%ELLIPSEECCENTRICITY compute the eccentricity of the ellipse given the length of the
%semi-axes.
arguments
    semiAxes (:, 2) double {mustBePositive}
end

% Eccentricity is sqrt(1 - b^2 / a^2)
e = sqrt(1 - semiAxes(:, 2).^2 / semiAxes(:, 1).^2);

end