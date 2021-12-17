classdef Propagator
    properties
        abstol (1, 1) double {mtd.util.mustBeValidTolerance} = 1e-12
        reltol (1, 1) double {mtd.util.mustBeValidTolerance} = 1e-12
        eventFunctions = []
    end
end