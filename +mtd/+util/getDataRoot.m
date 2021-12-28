function path = getDataRoot(relativePaths)
%GETDATAROOT return the path to the root of the data directory
arguments
    relativePaths string = ""
end

% Name of the data directory relative to mtd root
DATA_DIRECTORY_PATH = "data";

basepath = fullfile(mtd.util.getMtdRoot, DATA_DIRECTORY_PATH);
path = strings(length(relativePaths));
for k = 1:length(relativePaths)
    path(k) = fullfile(basepath, relativePaths(k));
end

end