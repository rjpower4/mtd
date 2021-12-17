classdef Sphere < mtd.geometry.Ellipsoid
    properties
        radius
    end

    methods
        function this = Sphere(radius)
            arguments
                radius {mustBePositive}
            end
            this = this@mtd.geometry.Ellipsoid(radius, radius, radius);
            this.radius = radius;
        end

        function sa = getSurfaceArea(this)
            sa = 4 .* pi .* this.radius.^2;
        end
    end
end