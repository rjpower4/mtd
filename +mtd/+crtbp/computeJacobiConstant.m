function jc = computeJacobiConstant(massRatio, qs)
%COMPUTEJACOBICONSTANT compute the CRTBP Jacobi constant that is a scalar multiple of
%the Hamiltonian
arguments
    massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
    qs (:, 6) double
end
omega = mtd.crtbp.computePseudopotential(massRatio, qs);
v2 = sum(qs(:, 4:6).^2, 2);
jc = 2 .* omega - v2;
end