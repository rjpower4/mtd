function qL = convertHamiltonianToLagrangian(qH)
%CONVERTHAMILTONIANTOLAGRANGIAN convert states in the Hamiltonian basis to states in the
%Lagrangian basis.
%
%   [QL] = CONVERTHAMILTONIANTOLAGRANGIAN(QH) convert the states in the hamiltonian basis
%   that are the rows of QH to the lagrangian basis as the rows of QL.
arguments
    qH (:, 6) double % Input states in hamiltonian basis
end

% Conversion tensor
W = mtd.util.angularVelocityTensor([0, 0, -1]);
T = [eye(3), zeros(3); W, eye(3)];

% Perform transformation as matrix multiplication
qL = transpose(T * transpose(qH));

end