function t = getBodyDataTable(names)
%GETBODYDATATABLE return the table of body data

config = mtd.util.getConfiguration();
files = mtd.util.getDataRoot(config.body_files(:).body_file);
t = readtable(files(1));

if nargin > 0
    filter = find(sum(t.name == upper(names), 2));
    t = t(filter, :);
end

end