classdef PathResolutionTests < matlab.unittest.TestCase
    methods (Test)
        function testAbsolutePaths(testCase)
            currentFilePath = string(mfilename("fullpath"));
            output = mtd.util.resolvePath(currentFilePath, string(pwd));
            testCase.assertEqual(output, currentFilePath);
        end
    end
end