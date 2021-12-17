function absolutePath = resolvePath(paths, base)
%RESOLVEPATH convert the filepath(s) to absolute if not already
%
%   Often, a path is given as input and it is unclear if it is an absolute
%   path (referenced from the root of the filesystem) or a relative path
%   (referenced from the current working directory). This function converts
%   all paths (absolute AND relative) into absolute paths.
%
%   [ABSOLUTEPATHS] = RESOLVEPATH(PATHS) for each PATH in the array of
%   strings, PATH, determine if the PATH is absolute. If it is, return it,
%   if it is not convert to an absolute path relative to the current
%   working directory and return that.
%
%   [ABSOLUTEPATHS] = RESOLVEPATH(PATHS, BASE) for each PATH in the array
%   of strings, PATH, determine if the PATH is absolute. If it is, return
%   it,if it is not convert to an absolute path relative to the path
%   specified in BASE and return that.
%
%   See also: pwd
arguments
    paths string {mustBeVector}
    base (1, 1) string = pwd
end

% Pre-allocate array of strings here. Doesn't really speed anything up
% but stops MATLAB from yelling at us.
absolutePath = strings(length(paths), 1);

for k = 1:length(paths)
    % I don't know of a way to check if absolute using any of MATLAB's
    % built-ins,but it's relatively trivial using the Java File object
    % as it's just a method call.
    %
    % For more information on this class, see here:
    %   https://www.geeksforgeeks.org/file-class-in-java/
    fp = java.io.File(paths(k));
    if fp.isAbsolute()
        absolutePath(k) = paths(k);
    else
        absolutePath(k) = fullfile(base, paths(k));
    end
end
end