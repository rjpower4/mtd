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

    methods (Static)
        function bodies = fromTable(t)
            %FROMTABLE construct a body for each row in the table
            row = t(size(t, 1), :);
            bodies(size(t, 1), 1) = mtd.body.CelestialBody(row.gm, row.naif_id, row.radius);
            for kRowNum = size(t, 1)-1:-1:1
                row = t(kRowNum, :);
                bodies(kRowNum, 1) = mtd.body.CelestialBody(row.gm, row.naif_id, row.radius);
            end
        end

        function bodies = fromName(names)
            %FROMNAME construct a body from the name of the body
            t = mtd.util.getBodyDataTable(names);
            [r, ~] = find(t.name == names);
            t = t(r, :);
            bodies = mtd.body.CelestialBody.fromTable(t);
        end
    end
end