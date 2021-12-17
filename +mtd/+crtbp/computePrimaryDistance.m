function dr = computePrimaryDistance(massRatio, q)
    %COMPUTEPRIMARYDISTANCE compute the distances to each of the primaries in the CRTPB as
    %well as the barycenter.
    arguments
        massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio} % CRTBP mass ratio
        q (:, 6) double % States
    end
    [dq1, dq2, dqB] = mtd.crtbp.computeRelativePrimaryState(massRatio, q);
    dr = zeros(size(dq1, 1), 3);
    dr(:, 1) = sum(dq1(:, 1:3).^2, 2);
    dr(:, 2) = sum(dq2(:, 1:3).^2, 2);
    dr(:, 3) = sum(dqB(:, 1:3).^2, 2);
end