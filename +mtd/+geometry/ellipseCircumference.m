function c = ellipseCircumference(semiAxes)
%ELLIPSECIRCUMFERENCE compute an approximate circumference for the ellipse with given
%semiAxes.
arguments
    semiAxes (:, 3) double {mustBePositive}
end

% The approximation for the circumference is derived via an expansion about h, where the
% value of h is given by:
%   h = (a - b)^2 / (a + b)^2
% Here I am trying to optimize calculation of this. Notice that the value is invariant
% under the renaming (a -> b, b -> a) so we don't care about which is larger.
a2 = semiAxes(:, 1).^2;
b2 = semiAxes(:, 2).^2;
tab = 2 .* semiAxes(:, 1) .* semiAxes(:, 2);
ab2 = a2 + b2;
h = (ab2 - tab) ./ (ab2 + tab);

% This approximation should be close up to the order of h^5
c = pi .* sum(semiAxes, 2) .* (1 + 3 .* h ./ (10 + sqrt(4 - 3 .* h)));

end