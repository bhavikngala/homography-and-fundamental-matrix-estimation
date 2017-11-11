function [r, c, nCorr] = getPutativeMatches(normCorr, howMany, ...
    thresholdPercent)
%TOPFEWHUNDREDCORRELATEDDESCRIPTORS Summary of this function goes here
%   Detailed explanation goes here
%     returns the pairs with the highest correlation

    [maxCorr, I2Coords] = max(normCorr');
    [maxCorr, sortedIndices] = sort(maxCorr, 'descend');
    
    if size(sortedIndices, 2) > howMany
        r = sortedIndices(1:howMany);
        c = I2Coords(r);
        nCorr = maxCorr(1:howMany);
    else
        r = sortedIndices;
        c = I2Coords;
        nCorr = maxCorr;
    end;

end

