classdef Constants
    %CONSTANTS useful constant definitions
    %
    %   Dimensions
    %       In the documentation comments below, dimensions are defined
    %       using the following shorthand:
    %           - M: Mass
    %           - L: Length
    %           - T: Time
    %           - K: Temperature
    %       The superscripts for each of these are given for each quantity
    %       so that if (non-)dimensionalization is needed, you don't need
    %       to search on wikipedia. You're welcome.
    %
    %   Author: Rolfe Power

    properties (Constant)
        % Universal Constant of Gravitation
        %
        %   This is also known as the Newtonian Constant of Gravitation and
        %   the Cavendish Gravitational Constant. In the classical
        %   (Newtonian) formulation of gravity, this value serves as the
        %   constant of proportionality between the force exterted between
        %   two bodies and the sum of their products divided by the square
        %   of the distance between them.
        %
        %   Note that the value of this constant is only really known to
        %   about four significant figures. Therefore, if its use can be
        %   avoided it should be.
        %
        %   Dimensions : [M^(-1) L^3 T^(-2)]
        %   Units      : [km^3 / (kg . s^2)]
        %   Sources    : <a href="matlab:web('https://physics.nist.gov/cuu/Constants/')">NIST</a>
        %                <a href="matlab:web('https://arxiv.org/abs/1507.07956')">CODATA</a>
        GRAVITATIONAL_CONSTANT = 6.6743e-20
        
        % Astronomical Unit
        %
        %   Unit of length that is about equal to the distance from the
        %   Earth to the Sun. According to WikiPedia, the distance from the
        %   Earth to the Sun varies by about 3% over the course of a year
        %   so this value could be (in theory) about 3% off the distance
        %   for any given epoch. However, the use case of this unit is that
        %   it is a convenient scaling factor for distances of solar system
        %   magnitudes as it is officially defined.
        %
        %   Dimensions : [L]
        %   Units      : [km]
        %   Sources    : <a href="matlab:web('https://www.iau.org/static/resolutions/IAU2012_English.pdf')">IAU</a>
        ASTRONOMICAL_UNIT = 149597870.700
        
        % Standard Gravity
        %
        %   Also called Standard Acceleration Due to Gravity or Standard
        %   Acceleration of Free Fall. This is the "nominal" gravitational
        %   acceleration of an object in a vacuum near the Earth's surface
        %   according to Wikipedia. Note that this is a _defined_ quantity,
        %   not a universal constant.
        %
        %   Dimensions : [L T^(-2)]
        %   Units      : [km / s^2]
        %   Sources    : <a href="matlab:web('https://physics.nist.gov/cuu/Constants/')">NIST</a>
        STANDARD_GRAVITY = 9.80665e-03
        
        % Mass of the Proton
        %
        %   Protons are the positively charged subatomic particles and this
        %   is their mass (meant to be read like the intro to Law and
        %   Order).
        %
        %   Dimensions : [M]
        %   Units      : [kg]
        %   Source     : <a href="matlab:web('https://physics.nist.gov/cuu/Constants/')">NIST</a>
        PROTON_MASS = 1.67262192369e-27
        
        % Mass of the Neutron
        %
        %   Dimensions : [M]
        %   Units      : [kg]
        %   Source     : <a href="matlab:web('https://physics.nist.gov/cuu/Constants/')">NIST</a>
        %                <a href="matlab:web('https://en.wikipedia.org/wiki/Jimmy_Neutron:_Boy_Genius')">Jimmy</a>
        NEUTRON_MASS = 1.67492749804e-27
        
        % Mass of the Electron
        %
        %   Dimensions : [M]
        %   Units      : [kg]
        %   Source     : <a href="matlab:web('https://physics.nist.gov/cuu/Constants/')">NIST</a>
        ELECTRON_MASS = 9.1093837015e-31

        % Atomic Mass Unit
        %
        %   This is defined as one twelfth the mass of a Carbon-12 atom.
        %
        %   Dimensions : [M]
        %   Units      : [kg]
        %   Source     : <a href="matlab:web('https://arxiv.org/abs/1507.07956')">CODATA</a>
        ATOMIC_MASS_UNIT = 1.660539040e-27
        
        % Speed of Light in a Vacuum
        %
        %   Also called lightspeed (but please, no). Note that this value
        %   is exact because the meter is defined in terms of it. Light
        %   will be slower in other mediums, but in a vacuum, this is when
        %   it is fastest.
        %
        %   Dimensions : [L T^(-1)]
        %   Units      : [km / s]
        %   Source     : <a href="matlab:web('https://physics.nist.gov/cuu/Constants/')">NIST</a>
        SPEED_OF_LIGHT = 299792458e-3
        
        % Boltzmann Constant
        %
        %   Dimensions : [M L^2 T^(-2) K^(-1)]
        %   Units      : [J/K]
        %   Source     : <a href="matlab:web('https://physics.nist.gov/cuu/Constants/')">NIST</a>
        BOLTZMANN_CONSTANT = 1.380649e-23
    end

end