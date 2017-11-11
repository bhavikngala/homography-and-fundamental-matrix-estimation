function [numInliers, numOutliers, consensusXY, consensusXYPrime, ...
    inlierResidue] = ransacVoting(xy, xyprime, H, threshold)
%COMPUTEINLIERSOUTLIERSFORMODEL Summary of this function goes here
%   Detailed explanation goes here
    numInliers = 0;
    numOutliers = 0;
    
    consensusXY = zeros([4, 2]);
    consensusXYPrime = zeros([4, 2]);
    inlierResidue = 0;

    consensusIndex = 1;
    for i=1:1:size(xy, 1)
%         step 1 compute (x', y') from H and (x, y)
        xprimeyprime = H * [xy(i, :)'; 1];
        xprimeyprime = bsxfun(@rdivide, xprimeyprime, xprimeyprime(3, 1));
        
%         step 2 compute error
        error = sum((xprimeyprime(1:2, :) - xyprime(i, :)').^2);
        
%         step 3 threshold inlier or outlier
        if error <= threshold
            numInliers = numInliers + 1;
            consensusXY(consensusIndex, :) = xy(i, :);
            consensusXYPrime(consensusIndex, :) = xyprime(i, :);
            inlierResidue = inlierResidue + error;
            consensusIndex = consensusIndex + 1;
        else
            numOutliers = numOutliers + 1;
        end;
    end;

end