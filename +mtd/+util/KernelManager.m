classdef KernelManager

    properties (Access = private)
        kernelsWithDuplicates
        uniqueKernels
    end

    methods
        function self = KernelManager(cc)
            ifiles = cc.kernelDefinitionFiles;
            xmlOptions = detectImportOptions(ifiles(1));
            xmlOptions.VariableTypes(5) = "logical";
            kernels = readtable(ifiles(1), xmlOptions);
            for k = 2:length(ifiles)
                kdata = readtable(ifiles(k), xmlOptions);
                kernels = union(kernels, kdata);
            end
            self.kernelsWithDuplicates = kernels;
            [~, uInds] = unique(self.kernelsWithDuplicates.name);
            self.uniqueKernels = self.kernelsWithDuplicates(uInds, :);
        end

        function t = getKernels(self)
            t = self.uniqueKernels;
        end

        function kerns = getDefaultKernels(self)
            t = self.getKernels();
            kerns = t(t.default, :);
        end

        function t = getKernelVariants(self, name)
            t = self.kernelsWithDuplicates(self.kernelsWithDuplicates.name == name, :);
        end
    end
end