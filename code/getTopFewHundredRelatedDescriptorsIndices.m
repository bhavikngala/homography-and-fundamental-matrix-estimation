function [r, c, nCorr] = getTopFewHundredRelatedDescriptorsIndices( ...
    normCorr, howMany, thresholdPercent)
%TOPFEWHUNDREDCORRELATEDDESCRIPTORS Summary of this function goes here
%   Detailed explanation goes here
    threshold = max(normCorr(:)) * thresholdPercent / 100;
    
%     find values above threshold
%     can improve performance with logical indicing
    indicesOfValuesAboveOrEqualToThreshold = find(normCorr >= threshold);
    
%     sort valuesAboveThreshold based on values
    [values, indicesOfValuesAboveOrEqualToThreshold] = sort( ...
        normCorr(indicesOfValuesAboveOrEqualToThreshold), 'descend');
    
%     return top howMany indices for the descriptors
    if size(indicesOfValuesAboveOrEqualToThreshold, 1) >= howMany 
        [r, c] = ind2sub(size(normCorr), ... 
            indicesOfValuesAboveOrEqualToThreshold(1:howMany));
        nCorr = values(1:howMany);
    else
        [r, c] = ind2sub(size(normCorr), ...
            indicesOfValuesAboveOrEqualToThreshold);
        nCorr = values;
    end;

end

