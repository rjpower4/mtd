classdef ConfigurationContext < handle
    %CONFIGURATIONCONTEXT manages configuration information for MTD
    %
    %   This is a singleton... I know, but I don't know of a better way to handle this
    %   configuration.
    %
    %   Author: Rolfe Power

    properties (Constant)
        configurationFileName = "config.xml" % Name of the default configuration file
        dataDirectoryName = "data" %  Name of the data directory relative to MTD root
    end

    properties (Access = private)
        datasetManager (1, 1)
        dataRoot
    end

    methods
        function this = ConfigurationContext()
            %CONFIGURATIONCONTEXT create a new configuration context
            %
            %   This function will error if the hardcoded configuration file cannot be 
            %   found!


            this.dataRoot = fullfile(this.getMtdRoot, this.dataDirectoryName);

            % Error out if config file not found
            fname = this.configurationFileName;
            fpath = fullfile(this.getDataRoot, fname);
            if ~isfile(fpath)
                error("Cannot find configuration file: %s", fpath);
            end
            rawConfiguration = readstruct(fpath);
            dfiles = rawConfiguration.dataset_definition_paths.path;
            this.datasetManager = mtd.util.DataSetManager(this.getDataRoot, dfiles);
        end

        function dm = getDataSetManager(self)
            dm = self.datasetManager;
        end

        function path = getConfigFilePath(self)
            %GETCONFIGFILEPATH get the path to the configuration file
            path = fullfile(self.getDataRoot, self.configurationFileName);
        end

        function path = getDataRoot(this)
            %GETDATAROOT return the path to the mtd data directory
            path = this.dataRoot;
        end

    end

    methods (Static)
        function path = getMtdRoot()
            %GETMTDROOT return the path to the +mtd directory
            path = fileparts(fileparts(mfilename("fullpath")));
        end

        function obj = instance()
            %INSTANCE return the configuration context instance, creating it if non-existent
            persistent uniqueInstance
            if isempty(uniqueInstance)
                obj = ConfigurationContext();
                uniqueInstance = obj;
            else
                obj = uniqueInstance;
            end
        end
    end
end