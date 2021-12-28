function path = getConfigurationFilePath()
%GETCONFIGURATIONFILEPATH return the path to the config file
CONFIG_FILE_NAME = "config.xml";
path = fullfile(mtd.util.getDataRoot, CONFIG_FILE_NAME);
end