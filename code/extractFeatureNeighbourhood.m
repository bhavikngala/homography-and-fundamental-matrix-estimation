function [descriptors] = extractFeatureNeighbourhood(I, r, c, ...
    neighourhoodSize)
%EXTRACTFEATURENEIGHBOURHOOD Summary of this function goes here
%   Detailed explanation goes here

    [rows, cols] = size(I);
    descriptors = zeros([10, neighourhoodSize]);
    descriptorRowIndex = 1;
    
    for i=1:1:size(r, 1)
        xOffset = floor(c(i, 1) / 2);
        yOffset = floor(r(i, 1) / 2);
        sx = c(i, 1) - xOfffset;
        sy = r(i, 1) - yOffset;
        ex = c(i, 1) + xOffset;
        ey = c(i, 1) + yOffset;
        
        if 1 <= sy && rows >= ey && 1 <= sx && cols >= ex
            temp = I(sy:ey, sx:ex);
            descriptors(descriptorRowIndex, :) = temp(:);
            descriptorRowIndex = descriptorRowIndex + 1;
        end;
    end;

end

