classdef Colors
    properties (Constant)
        %% Purdue Colors
        GOLD         = mtd.Colors.toMatlabRgb([207, 185, 145])
        AGED         = mtd.Colors.toMatlabRgb([142, 111,  62])
        RUSH         = mtd.Colors.toMatlabRgb([218, 170,   0])
        FIELD        = mtd.Colors.toMatlabRgb([221, 185,  69])
        DUST         = mtd.Colors.toMatlabRgb([235, 217, 159])
        BLACK        = mtd.Colors.toMatlabRgb([  0,   0,   0])
        STEEL        = mtd.Colors.toMatlabRgb([ 85,  89,  96])
        COOL_GRAY    = mtd.Colors.toMatlabRgb([111, 114, 123])
        RAILWAY_GRAY = mtd.Colors.toMatlabRgb([157, 151, 149])
        STEAM        = mtd.Colors.toMatlabRgb([196, 191, 192])

        %% Misc
        ROBERT_GREEN = [0, 0.5, 0]
    end

    methods (Static)
        function mrgb = toMatlabRgb(rgb)
            %TOMATLABRGB convert a standard rgb array on range [0, 255] to MATLAB's
            %scaling which is on the range [0, 1]
            mrgb = rgb ./ 255;
        end
    end
end