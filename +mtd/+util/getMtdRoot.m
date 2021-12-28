function path = getMtdRoot()
%GETMTDROOT return the path to the root directory of MTD.

path = string(fileparts(fileparts(mfilename("fullpath"))));

end