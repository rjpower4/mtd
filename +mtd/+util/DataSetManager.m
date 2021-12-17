classdef DataSetManager < handle
    properties
        dataRoot
        definitionFiles (:, 1)
        datasets
    end

    methods (Access = ?mtd.util.ConfigurationContext)
        function this = DataSetManager(dataRoot, paths)
            import mtd.util.*

            this.dataRoot = dataRoot;

            % Ensure that the paths are absolute paths
            absolutePaths = resolvePath(paths, dataRoot);

            % Get paths
            this.definitionFiles = strings(0, 1);
            count = 1;
            for k = 1:length(absolutePaths)
                pth = absolutePaths(k);
                if ~isfolder(pth)
                    this.definitionFiles(count) = pth;
                    count = count + 1;
                else
                    npStructs = dir(fullfile(pth, "**\*.xml"));
                    nps = arrayfun(@(x) string(fullfile(x.folder, x.name)), npStructs);
                    for newPathNum = 1:length(nps)
                        this.definitionFiles(count) = nps(newPathNum);
                        count = count + 1;
                    end
                end
            end

            % Load in the data
            dsets = cell(length(this.definitionFiles), 1);
            for k = 1:length(this.definitionFiles)
                opts = detectImportOptions(this.definitionFiles(k));
                opts = setvartype(opts, "default", "logical");
                dsets{k} = readtable(this.definitionFiles(k), opts);
            end

            this.datasets = dsets{1};
            for k = 2:length(dsets)
                this.datasets = union(this.datasets, dsets{k});
            end
        end

    end

    methods
        function ds = getPrimaryDataSets(this)
            % Return the primary datasets, i.e., those that are first with their name
            [~, uInds] = unique(this.datasets.name);
            ds = this.datasets(uInds, :);
        end

        function ds = getDefaultDataSets(this)
            ds = this.getPrimaryDataSets();
            ds = ds(ds.default, :);
        end

        function fetchDataset(this, name, here)
            arguments
                this
                name string
                here logical = false
            end
            r = this.getDataSetInformation(name);
            fname = r.filename;
            url = r.url;
            if ~here
                pth = fullfile(this.dataRoot, "datasets", fname);
            else
                pth = fullfile(pwd, fname);
            end
            fprintf("Fetching %s ...", pth)
            websave(pth, url);
            fprintf("done\n");
        end

        function fetchDefaultDataSets(this)
            ds = this.getDefaultDataSets;
            for k = 1:size(ds, 1)
                fname = ds.filename(k);
                pth = fullfile(this.dataRoot, "datasets", fname);
                if ~isfile(pth)
                    fprintf("Fetching %s ...", pth)
                    websave(pth, ds.url(k));
                    fprintf("done\n");
                else
                    warning("File %s already found, skipping...", pth);
                end
            end
        end

        function info = getDataSetInformation(this, name)
            %GETDATASETINFORMATION return the row in the dataset table corresponding to
            %primary version of requested dataset. Error on not found.
            candidates = this.datasets.name == name;
            if ~any(candidates)
                error("Dataset %s not found", name)
            end
            clocs = find(candidates);
            selection = clocs(1);
            info = this.datasets(selection, :);
        end
    
        function pth = getDataSetPath(this, name)
            %GETDATASETPATH return path on disk to where the dataset is or would be stored
            r = this.getDataSetInformation(name);
            fname = r.filename;
            pth = fullfile(this.dataRoot, "datasets", fname);
        end

        function found = hasDataSet(this, name)
            %HASDATASET return true if dataset is known to manager, false otherwise
            found = any(this.datasets.name == name);
        end
    end
end