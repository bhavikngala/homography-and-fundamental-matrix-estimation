function [T] = computeCoordinateNormalizingMatrix(xy)
%COMPUTECOORDINATENORMALIZINGMATRIX Summary of this function goes here
%   Detailed explanation goes here
%     constructs a non isotropic normalization matrix for input coordinates

%     Non isotropic normalization
%     compute mean of x coordinates and y coordinates
    xymean = mean(xy);
    principalmoments = max(xy);
    
%     construct the matrix
    T = [1/principalmoments(1,1), 0, -1*xymean(1, 1)/principalmoments(1,1);
         0, 1/principalmoments(1,2), -1*xymean(1, 2)/principalmoments(1,2);...
         0       0        1];

end