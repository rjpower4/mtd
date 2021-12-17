classdef CelestialBody
    properties
        gravitationalParameter double {mustBePositive}
    end

    methods
        function this = CelestialBody(gm)
            this.gravitationalParameter = gm;
        end
        
        function m = getMass(this)
            %GETMASS calculate and return the mass of the celestial body
            m = this.gravitationalParameter / mtd.Constants.GRAVITATIONAL_CONSTANT;
        end
    end
end