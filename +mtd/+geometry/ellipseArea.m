function a = ellipseArea(semiAxes)
%ELLIPSEAREA calculate the area of the ellipse given the semi-axes lengths
%
%   [A] = ELLIPSEAREA(SEMIAXES) computes the area of the ellipse with given semi-major
%   axes. The semi-axes must be the columns of SEMIAXES with each row of SEMIAXES
%   corresponding to a different ellipse. The rows of A will correspond to the rows of
%   SEMIAXIS.
arguments
    semiAxes (:, 3) double {mustBePositive}
end

a = pi .* prod(semiAxes, 2);

end