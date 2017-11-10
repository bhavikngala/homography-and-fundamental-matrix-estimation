function [T] = computeCoordinateNormalizingMatrix(xy)
%COMPUTECOORDINATENORMALIZINGMATRIX Summary of this function goes here
%   Detailed explanation goes here

%     compute mean of x coordinates and y coordinates
    xymean = mean(xy);

%     substract xmean from x and ymean from y
%     compute distance from origin
%     xydist = sqrt(sum((bsxfun(@minus, xy ,xymean)).^2, 2));
    xydist = sqrt(sum(xy.^2, 2));

%     compute variance of distances from origin
    xyvar = var(xydist);
    
%     construct the matrix
    T = [1/xyvar 0       -1*xymean(1, 1);...
         0       1/xyvar -1*xymean(1, 2);...
         0       0        1];

end