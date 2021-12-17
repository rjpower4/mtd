function output = resolvePath(paths, base)
%RESOLVEPATH convert the filepath(s) to absolute if not already
    arguments
        paths string {mustBeVector}
        base (1, 1) string
    end
    output = strings(length(paths), 1);
    for k = 1:length(paths)
        fp = java.io.File(paths(k));
        if fp.isAbsolute()
            output(k) = paths(k);
        else
            output(k) = fullfile(base, paths(k));
        end
    end
end