function h = computeHamiltonian(massRatio, q)
    %COMPUTEHAMILTONIAN compute the hamiltonian for the CRTBP
    x = q(:, 1);
    y = q(:, 2);
    vx = q(:, 4);
    vy = q(:, 5);
    vz = q(:, 6);

    % Calculate the conjugate momenta
    px = vx - y;
    py = vy + x;
    pz = vz;

    % Get primary distances
    dr = mtd.crtbp.computePrimaryDistance(massRatio, q);
    d1 = dr(:, 1);
    d2 = dr(:, 2);

    % Calculate the hamiltonian
    p2 = px.^2 + py.^2 + pz.^2;
    h = 1/2 .* p2 + px .* y - py .* x - (1 - massRatio) ./ d1 - massRatio ./ d2;
end