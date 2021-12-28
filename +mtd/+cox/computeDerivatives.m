function [dq, jacState, jacControl] = computeDerivatives(massRatio, q, a)
%COMPUTEDERIVATIVES evaluate the equations of motion for the CRTBP+LT introduced by Andrew
%cox.
%
%   [DQ] = COMPUTEDERIVATIVES(MU, Q, A) compute the CRTBP+LT equations of motion for the
%   system with mass ratio value of MU at the state(s) Q. The input parameter A defines
%   the low-thrust acceleration vector.
%
%   [DQ, JAC] = COMPUTEDERIVATIVES(MU, Q, A) compute the CRTBP+LT equations of motion for 
%   the system with mass ratio value of MUat the state(s) Q. The input parameter A defines
%   the low-thrust acceleration vector. Additionally, compute the first order partials 
%   (JAC) for the equations of motion at the state(s) Q.
arguments
    massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
    q (:, 6) double
    a (:, 3) double
end

if nargout == 1
    dq = mtd.crtbp.computeDerivatives(massRatio, q);
else
    [dq, jacState] = mtd.crtbp.computeDerivatives(massRatio, q);
    
    if nargout > 2
        nStates = size(q, 1);
        jacControl = zeros(6, 3, nStates);
        jacControl(4, 1, :) = 1;
        jacControl(5, 2, :) = 1;
        jacControl(6, 3, :) = 1;
    end
end

dq(:, 4) = dq(:, 4) + a(:, 1);
dq(:, 5) = dq(:, 5) + a(:, 2);
dq(:, 6) = dq(:, 6) + a(:, 3);

end