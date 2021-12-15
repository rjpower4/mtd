function mustBeAValidMassRatio(massRatio)
    if massRatio > 0.5 || massRatio <= 0
        eidType = 'mustBeAValidMassRatio:invalidMassRatio';
        msgType = "Mass ratio must be on range (0, 0.5]";
        throwAsCaller(MException(eidType, msgType));
    end
end