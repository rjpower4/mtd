function [dq, jacobian] = computeDerivatives(massRatio, q)
%COMPUTEDERIVATIVES evaluate the equations of motion for the CRTBP
%
%   [DQ] = COMPUTEDERIVATIVES(MU, Q) compute the CRTBP equations of motion for the
%   system with mass ratio value of MU at the state(s) Q. 
%
%   [DQ, JAC] = COMPUTEDERIVATIVES(MU, Q) compute the CRTBP equations of motion for 
%   the system with mass ratio value of MUat the state(s) Q. Additionally, compute the
%   first order partials (JAC) for the equations of motion at the state(s) Q.
arguments
    massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
    q (:, 6) double
end

nStates = size(q, 1);

if nargout == 1
    [~, pGradient] = mtd.crtbp.computePseudopotential(massRatio, q);
elseif nargout > 1
    [~, pGradient, pHessian] = mtd.crtbp.computePseudopotential(massRatio, q);
end

dq = zeros(nStates, 6);
dq(:, 1:3) = q(:, 4:6);
dq(:, 4) = 2 * q(:, 5) + pGradient(:, 1);
dq(:, 5) = -2 * q(:, 4) + pGradient(:, 2);
dq(:, 6) = pGradient(:, 3);

% If nargout == 2, then the jacobian was requested
if nargout > 1
    jacobian = zeros(6, 6, nStates);
    jacobian(1, 4, :) = 1;
    jacobian(2, 5, :) = 1;
    jacobian(3, 6, :) = 1;
    jacobian(4:6, 1:3, :) = pHessian;
    jacobian(4, 5, :) = 2;
    jacobian(5, 4, :) = -2;
end

end