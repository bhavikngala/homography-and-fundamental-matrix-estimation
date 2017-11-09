function [stitchedImage] = stitchImagesBasedOnHomography(I1, I2, H)
%STITCHIMAGESBASEDONHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here
    [y, x] = size(I2);
    source = [1 1 x x; ...
              1 y 1 y; ...
              1 1 1 1];
    dest = H * source;
    dest = bsxfun(@rdivide, dest, dest(3, :));
    
    T1 = maketform('projective', source(1:2, :)', dest(1:2, :)');
    [I1T, xdata, ydata] = imtransform(I1, T1, 'bicubic');
%     figure; imshow(I1T);
    
    T2 = maketform('projective', dest(1:2, :)', source(1:2, :)');
    [I2T, xdata, ydata] = imtransform(I2, T2, 'bicubic');
%     figure; imshow(I2T);
    
%     find the farthest point in the negative x direction
    nx = abs(ceil(min(dest(1, :))));
    ny = abs(ceil(min(dest(2, :))));
    
%     find the farthest point in the positive y direction
    px = abs(ceil(max(dest(1, :))));
    py = abs(ceil(max(dest(2, :))));
    
    [i2r, i2c] = size(I2);
    
    composite1 = zeros([ny + i2r + 1, nx + i2c + 1]);
    composite2 = zeros([ny + i2r + 1, nx + i2c + 1]);
    
    [r, c] = size(I1T);
    composite1(1:r, 1:c) = I1T;
    composite2(ny + 2:ny + i2r + 1, nx + 2:nx + i2c + 1) = I2;
    disp('composite 1')
    size(composite1)
    disp('composite 2')
    size(composite2)
    
    stitchedImage = composite1 + composite2;
    overlap = composite1 & composite2;
    stitchedImage(overlap) = stitchedImage(overlap)/2;
    
    figure; imshow(stitchedImage);

end

