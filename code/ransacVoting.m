function [numInliers, numOutliers, consensusXY, consensusXYPrime] = ...
    ransacVoting(xy, xyprime, H, threshold)
%COMPUTEINLIERSOUTLIERSFORMODEL Summary of this function goes here
%   Detailed explanation goes here

    for i=1:1:size(xy, 1)
        xprimeyprime = H * [xy(i, :)'; 1];
        xprimeyprime = xprimeyprime ./ xprimeyprime(3,1);
        xprimeyprime = bsxfun(@rdivide, xprimeyprime, xprimeyprime(3, 1));
        
    end;

end

