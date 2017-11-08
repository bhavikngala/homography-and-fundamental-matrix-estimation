function [stitchedImage] = stitchImagesBasedOnHomography(I1, I2, H)
%STITCHIMAGESBASEDONHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here
    [y, x] = size(I1);
    source = [0 0 x x; ...
              0 y 0 y; ...
              1 1 1 1];
    dest = H * source;
    dest = bsxfun(@rdivide, dest, dest(3, :));
    
    T1 = maketform('projective', source(:, 1:2), dest(:, 1:2));
    [I1T, xdata, ydata] = imtransform(I1, T1, 'bicubic');

end

