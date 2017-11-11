function [descriptors, descriptorRows, descriptorCols] = ...
    extractFeatureNeighbourhood(I, r, c, neighourhoodSize)
%EXTRACTFEATURENEIGHBOURHOOD Summary of this function goes here
%   Detailed explanation goes here
% extract neighbourhood of the feature

    [rows, cols] = size(I);
    descriptors = zeros([10, neighourhoodSize ^ 2]);
    descriptorRowIndex = 1;
    descriptorRows = zeros(10, 1);
    descriptorCols = zeros(10, 1);
    
    offset = floor(neighourhoodSize / 2);
    for i=1:1:size(r, 1)
        rs = r(i) - offset;
        cs = c(i) - offset;
        re = r(i) + offset;
        ce = c(i) + offset;
        
        if 1 <= rs && rows >= re && 1 <= cs && cols >= ce
            temp = I(rs:re, cs:ce);
            temp = temp';
            descriptors(descriptorRowIndex, :) = temp(:);
            descriptorRows(descriptorRowIndex, 1) = r(i);
            descriptorCols(descriptorRowIndex, 1) = c(i);
            descriptorRowIndex = descriptorRowIndex + 1;
        end;
    end;

end