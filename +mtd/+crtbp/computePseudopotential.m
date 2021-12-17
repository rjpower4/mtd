function varargout = computePseudopotential(massRatio, q)
%COMPUTEPSEUDOPOTENTIAL compute the CRTBP pseudopotential an optionally
%the partial derivatives
%
%
arguments
    massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
    q double
end
% Determine number of states passed for return array allocation
nStates = size(q, 1);

% Concision
mu = massRatio;
omm = 1 - mu;
q1 = q(:, 1); % X
q2 = q(:, 2); % Y
q3 = q(:, 3); % Z

% Distances to primary
dists = mtd.crtbp.computePrimaryDistance(massRatio, q);
d1 = dists(:, 1); % Distance from P1
d2 = dists(:, 2); % Distance from P2
varargout{1} = omm ./ d1 + mu ./ d2 + 0.5 * (q1.^2 + q2.^2);

% If 2 or more outputs were requested then second output is the
% gradient of the pseudopotential with respect to the position
% components. Each row corresponds to each state.
if nargout > 1
    d1_3 = dists(:, 1).^3; % Cube of distance from P1
    d2_3 = dists(:, 2).^3; % Cube of distance from P2
    dp = zeros(nStates, 3);
    dp(:, 1) = q1 - omm * (q1 + mu) ./ d1_3 - mu * (q1 - 1 + mu) ./ d2_3;
    dp(:, 2) = q2 - omm * q2 ./ d1_3 - mu * q2 ./ d2_3;
    dp(:, 3) = -omm * q3 ./ d1_3 - mu * q3 ./ d2_3;
    varargout{2} = dp;
end

% If 3 outputs were requested, then third output is the hessian of the
% pseudopotential with respect tot he position components. Each page of
% the 3-D matrix corresponds to each state.
if nargout > 2
    d1_5 = d1_3 .* dists(:, 1).^2; % Quintic of distance from P1
    d2_5 = d2_3 .* dists(:, 2).^2; % Quintic of distance from P2
    ddp = zeros(3, 3, nStates);
    k = -omm ./ d1_3 - mu ./ d2_3;

    % Diagonals
    ddp(1, 1, :) = k + 3*omm .* (q1 + mu).^2 ./ d1_5 + 3*mu * (q1 - omm).^2 ./ d2_5 + 1;
    ddp(2, 2, :) = k + 3*omm .*        q2.^2 ./ d1_5 + 3*mu *         q2.^2 ./ d2_5 + 1;
    ddp(3, 3, :) = k + 3*omm .*        q3.^2 ./ d1_5 + 3*mu *         q3.^2 ./ d2_5;

    % Upper Triangular (Not Including Diagonals)
    ddp(1, 2, :) = 3*omm * (q1 + mu) .* q2 ./ d1_5 + 3*mu * (q1 - omm) .* q2 ./ d2_5;
    ddp(1, 3, :) = 3*omm * (q1 + mu) .* q3 ./ d1_5 + 3*mu * (q1 - omm) .* q3 ./ d2_5;
    ddp(2, 3, :) = 3*omm *        q2 .* q3 ./ d1_5 + 3*mu *         q2 .* q3 ./ d2_5;

    % Each 2D Matrix is symmetric due to Clairaut's Theorem
    ddp(2, 1, :) = ddp(1, 2, :);
    ddp(3, 1, :) = ddp(1, 3, :);
    ddp(3, 2, :) = ddp(2, 3, :);

    varargout{3} = ddp;
end

end