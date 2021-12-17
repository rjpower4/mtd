classdef NaifBody < mtd.body.CelestialBody
    properties (SetAccess = private)
        naifIdCode {mustBeInteger}
        name string = "UNNAMED"
    end

    methods
        function this = NaifBody(gm, naifIdCode, name)
            arguments
                gm
                naifIdCode
                name = "UNNAMED"
            end
            this = this@mtd.body.CelestialBody(gm)
            this.naifIdCode = naifIdCode;
            this.name = name;
        end
    end
end