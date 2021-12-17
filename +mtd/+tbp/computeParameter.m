function p = computeParameter(sma, ecc)
%COMPUTEPARAMTER determine the parameter (semi-latus rectum) given the semi-major axis
%and the eccentricity

p = sma .* (1 - ecc.^2);

end