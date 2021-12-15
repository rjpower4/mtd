function [dq1, dq2, dqB] = computeRelativePrimaryState(massRatio, q)
    %COMPUTERELATIVEPRIMARYSTATE compute the state relative to the primary states in the
    %CRTBP
    arguments
        massRatio (1,1) double {mtd.crtbp.mustBeAValidMassRatio}
        q (:, 6) double
    end
    primaryStates = mtd.crtbp.computePrimaryState(massRatio);
    dq1 = q - primaryStates(1, :);
    dq2 = q - primaryStates(2, :);
    dqB = q - primaryStates(3, :);
end