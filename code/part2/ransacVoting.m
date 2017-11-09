function [numInliers, numOutliers, consensusXY, consensusXYPrime] = ...
    ransacVoting(xy, xyprime, F, threshold)
%COMPUTEINLIERSOUTLIERSFORMODEL Summary of this function goes here
%   Detailed explanation goes here
    numInliers = 0;
    numOutliers = 0;
    
    consensusXY = zeros([4, 2]);
    consensusXYPrime = zeros([4, 2]);

    for i=1:1:size(xy, 1)
%         step 1 compute x'Fx; should be zero
        s = [xyprime(i,:), 1] * F * [xy(i,:)'; 1];
        
%         step 2 compute error
        error = s^2;
        
%         step 3 threshold inlier or outlier
        if error <= threshold
            numInliers = numInliers + 1;
            consensusXY(i, :) = xy(i, :);
            consensusXYPrime(i, :) = xyprime(i, :);
        else
            numOutliers = numOutliers + 1;
        end;
    end;

end