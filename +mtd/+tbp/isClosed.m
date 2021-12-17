function tf = isClosed(ecc)
%ISCLOSED determine if orbit with given eccentricity is closed
arguments
    ecc {mustBeNonnegative}
end
tf = ecc < 1;
end