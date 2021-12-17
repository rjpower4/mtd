classdef Ellipsoid
    %ELLIPSOID class representing a general tri-axial ellipsoid defined by three
    %(not-necessarily distinct) positive semi-axes.
    properties (SetAccess = private)
        a double {mustBeVector} = nan
        b double {mustBeVector} = nan
        c double {mustBeVector} = nan
    end

    properties (Access = private)
        nEllipsoids {mustBeInteger}
    end

    methods
        function this = Ellipsoid(a, b, c)
            arguments
                a double {mustBePositive}
                b double {mustBePositive}
                c double {mustBePositive}
            end
            if length(a) ~= length(b) || length(b) ~= length(c)
                error("Incompatible vector lengths");
            end
            this.a = a;
            this.b = b;
            this.c = c;
            this.nEllipsoids = length(a);
        end

        function v = getVolume(this)
            %GETELLIPSOIDVOLUME calculate the volume of the ellipsoid(s) with the given semi-axis
            %lengths
            %
            %   A description of the equation used can be found <a
            %   href="https://mathworld.wolfram.com/Ellipsoid.html">here</a>.
            v = (4/3) .* pi .* this.a .* this.b .* this.c;
        end

        function inertia = getSpecificInertiaTensor(this)
            %GETSPECIFICINERTIATENSOR return the inertia tensor for the ellipsoid per unit
            %mass.
            %
            %   This is simply:
            %       1/5 (b^2 + c^2)         0               0
            %               0       1/5 (a^2 + c^2)         0
            %               0               0       1/5 (a^2 + b^2)
            inertia = zeros(3, 3, this.nEllipsoids);
            a2 = this.a.^2;
            b2 = this.b.^2;
            c2 = this.c.^2;
            inertia(1, 1, :) = 1/5 .* (b2 + c2);
            inertia(2, 2, :) = 1/5 .* (a2 + c2);
            inertia(3, 3, :) = 1/5 .* (a2 + b2);
        end
    end
end