function [meanNormalized] = meanNormalize(data)
%ZNORMALIZE Summary of this function goes here
%   Detailed explanation goes here

   data = data';
   dataMinusMean = bsxfun(@minus, data, mean(data));
   meanNormalized = bsxfun(@rdivide, dataMinusMean, std(data))';     

end