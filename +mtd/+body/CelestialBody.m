classdef CelestialBody
    %CELESTIALBODY class representing a celestial body
    properties (SetAccess = private)
        gravitationalParameter double {mustBePositive}
        naifIdCode {mustBeInteger}
        radius double
    end

    methods
        function this = CelestialBody(gm, naifId, radius)
            if nargin == 0
                this.gravitationalParameter = 1.0;
                this.naifIdCode = -1;
                this.radius = 1;
                return
            end
            this.gravitationalParameter = gm;
            this.naifIdCode = naifId;
            this.radius = radius;
        end
        end
    end
end