function [stitchedImage] = stitchImagesBasedOnHomography(I1, I2, H)
%STITCHIMAGESBASEDONHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here
    dest = [0 0 1 1; 0 1 0 1; 1 1 1 1];
    source = H * dest;
    source = bsxfun(@rdivide, source, source(3, :));

end

