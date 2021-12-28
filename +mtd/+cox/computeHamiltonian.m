function h = computeHamiltonian(massRatio, q, a)
%COMPUTEHAMILTONIAN compute the Hamiltonian in the CRTBP+LT problem
arguments
    massRatio (1, 1) double {mtd.crtbp.mustBeAValidMassRatio}
    q (:, 6) double
    a (:, 3) double
end

hNatural = mtd.crtbp.computeHamiltonian(massRatio, q);
h = hNatural - sum(q(:, 1:3) .* a, 2);

end