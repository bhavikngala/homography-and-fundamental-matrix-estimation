function [descriptors, descriptorRows, descriptorCols] = ...
    extractFeatureNeighbourhood(I, r, c, neighourhoodSize)
%EXTRACTFEATURENEIGHBOURHOOD Summary of this function goes here
%   Detailed explanation goes here

    [rows, cols] = size(I);
    descriptors = zeros([10, neighourhoodSize ^ 2]);
    descriptorRowIndex = 1;
    descriptorRows = zeros(10, 1);
    descriptorCols = zeros(10, 1);
    
    for i=1:1:size(r, 1)
        offset = floor(neighourhoodSize / 2);
        sx = r(i, 1) - offset;
        sy = c(i, 1) - offset;
        ex = r(i, 1) + offset;
        ey = c(i, 1) + offset;
        
        if 1 <= sy && rows >= ey && 1 <= sx && cols >= ex
            temp = I(sy:ey, sx:ex);
            temp = temp';
            descriptors(descriptorRowIndex, :) = temp(:);
            descriptorRows(descriptorRowIndex, 1) = r(i, 1);
            descriptorCols(descriptorRowIndex, 1) = c(i, 1);
            descriptorRowIndex = descriptorRowIndex + 1;
        end;
    end;

end