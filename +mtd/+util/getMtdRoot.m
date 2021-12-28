function path = getMtdRoot()
%GETMTDROOT return the path to the root directory of MTD.

path = fileparts(fileparts(mfilename("fullpath")));

end