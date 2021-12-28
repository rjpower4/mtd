function varargout = computePrimaryState(massRatio)
%COMPUTEPRIMARYSTATE calculate the states of the primaries and barycenter
arguments
    massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
end

x1 = -massRatio;
x2 = 1 - x1;
xB = 0;

% If one argument out, then return as matrix
if nargout == 1
    varargout{1} = zeros(3, 6);
    varargout{1}(1, 1) = x1; % State of P1
    varargout{1}(2, 1) = x2; % State of P2
    varargout{1}(3, 1) = xB; % State of P3
else
    varargout{1} = [-massRatio, 0, 0, 0, 0, 0];   % State of P1
    varargout{2} = [1-massRatio, 0, 0, 0, 0, 0];  % State of P2
    varargout{3} = zeros(1, 6);                   % State of Barycenter
end
end