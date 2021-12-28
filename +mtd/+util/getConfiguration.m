function config = getConfiguration()
%GETCONFIGURATION return the raw configuration struct
config = readstruct(mtd.util.getConfigurationFilePath());
end