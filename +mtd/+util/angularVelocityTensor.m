function T = angularVelocityTensor(omega)
%ANGULARVELOCITYTENSOR compute the angular velocity tensors for the angular velocities in
%OMEGA
arguments
    omega (:, 3) double
end

nVelocities = size(omega, 1);
T = zeros(3, 3, nVelocities);
T(1, 2, :) = -omega(:, 3);
T(1, 3, :) =  omega(:, 2);
T(2, 1, :) =  omega(:, 3);
T(2, 3, :) = -omega(:, 1);
T(3, 1, :) = -omega(:, 2);
T(3, 2, :) =  omega(:, 1);

end