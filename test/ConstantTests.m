classdef ConstantTests < matlab.unittest.TestCase
    methods (Test)
        function testValues(testCase)
            %TESTVALUES simple test to make sure the values aren't accidentally changed
            testCase.assertEqual(mtd.Constants.GRAVITATIONAL_CONSTANT, 6.6743e-20)
            testCase.assertEqual(mtd.Constants.ASTRONOMICAL_UNIT, 149597870.700)
            testCase.assertEqual(mtd.Constants.EARTH_STANDARD_GRAVITY, 9.80665e-03)
            testCase.assertEqual(mtd.Constants.PROTON_MASS, 1.67262192369e-27)
            testCase.assertEqual(mtd.Constants.NEUTRON_MASS, 1.67492749804e-27)
            testCase.assertEqual(mtd.Constants.ELECTRON_MASS, 9.1093837015e-31)
            testCase.assertEqual(mtd.Constants.SPEED_OF_LIGHT, 299792458e-3)
            testCase.assertEqual(mtd.Constants.BOLTZMANN_CONSTANT, 1.380649e-23)
        end
    end
end