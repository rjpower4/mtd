function [jc, varargout] = computeJacobiConstant(massRatio, qs)
%COMPUTEJACOBICONSTANT compute the CRTBP Jacobi constant that is a scalar multiple of
%the Hamiltonian; optionally compute jacobian and hessian of function as well
%
%   The Jacobi constant is given by the function:
%       JC = 2OMEGA(R) - V^2
%   where OMEGA(R) is the pseduopotential that is only a function of the position vector R
%   and V is the velocity magnitude.
arguments
    massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
    qs (:, 6) double
end

% Determine number of states passed in for allocation purposes
nStates = size(qs, 1);

% If we are to compute the gradient of the Jacobi constant, we'll need the gradient of
% omega and if we want to calculate the hessian, we'll need the hessian of omeg
if nargout < 2
    omega = mtd.crtbp.computePseudopotential(massRatio, qs);
elseif nargout == 2
    [omega, domega] = mtd.crtbp.computePseudopotential(massRatio, qs);
elseif nargout ==3
    [omega, domega, ddomega] =  mtd.crtbp.computePseudopotential(massRatio, qs);
end

v2 = sum(qs(:, 4:6).^2, 2);
jc = 2 .* omega - v2;

% If a second output is requested, we will provide the gradient of the Jacobi constant
% with respect to the state variables
if nargout > 1
    djc = zeros(nStates, 6);
    djc(:, 1:3) = 2 * domega;
    djc(:, 4:6) = -2 * qs(:, 4:6);
    varargout{1} = djc;
end

% Compute the hessian, actually relatively easy
if nargout > 2
    ddjc = zeros(6, 6, nStates);
    ddjc(1:3, 1:3, :) = 2 .* ddomega;

    % These three lines because `eye` doesn't work for 3D...
    ddjc(4, 4, :) = -2;
    ddjc(5, 5, :) = -2;
    ddjc(6, 6, :) = -2;

    varargout{2} = ddjc;
end
end