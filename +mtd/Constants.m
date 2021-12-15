classdef Constants
    %CONSTANTS useful constant definitions

    properties (Constant)
        % Universal constant of gravitation. [km^3 / (kg . s^2)]
        % Source: https://physics.nist.gov/cgi-bin/cuu/Value?bg|search_for=universal_in!
        GRAVITATIONAL_CONSTANT = 6.6743e-20
        
        % Astronomical unit as defined by the IAU. [km]
        % https://www.iau.org/static/resolutions/IAU2012_English.pdf
        ASTRONOMICAL_UNIT = 149597870.700
        
        % Standard gravitational acceleration at surface of Earth. [km/s^2]
        % https://physics.nist.gov/cgi-bin/cuu/Value?gn|search_for=adopted_in!
        EARTH_STANDARD_GRAVITY = 9.80665e-03
        
        % Mass of the proton. [kg]
        % https://physics.nist.gov/cgi-bin/cuu/Value?mp|search_for=atomnuc!
        PROTON_MASS = 1.67262192369e-27
        
        % Mass of the neutron. [kg]
        % https://physics.nist.gov/cuu/Constants/Table/allascii.txt
        NEUTRON_MASS = 1.67492749804e-27
        
        % Mass of the electron. [kg]
        % https://physics.nist.gov/cgi-bin/cuu/Value?mp|search_for=atomnuc!
        ELECTRON_MASS = 9.1093837015e-31
        
        % Speed of light in a vacuum. [km/s]
        % https://physics.nist.gov/cgi-bin/cuu/Value?c|search_for=adopted_in!
        SPEED_OF_LIGHT = 299792458e-3
        
        % Boltzmann constant. [J/K]
        BOLTZMANN_CONSTANT = 1.380649e-23
    end

end