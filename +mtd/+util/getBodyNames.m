function names = getBodyNames()
%GETBODYNAMES get the names of known bodies

t = mtd.util.getBodyDataTable();
names = t.name;

end