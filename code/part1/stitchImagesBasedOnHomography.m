function [stitchedImage] = stitchImagesBasedOnHomography(im1, im2, H)
%STITCHIMAGESBASEDONHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here
%     Stitches 2 images based on homography tranformation

    [y, x, ~] = size(im1);
    source = [1 1 x x; ...
              1 y 1 y; ...
              1 1 1 1];
    dest = H * source;
    dest = bsxfun(@rdivide, dest, dest(3, :));
    
    disp('source'); source
    disp('dest'); dest
    
    T1 = maketform('projective', source(1:2, :)', dest(1:2, :)');
    [I1T, xdata, ydata] = imtransform(im1, T1, 'bicubic');
    
%     find the farthest point in the negative x direction
    nx = min(dest(1, :));
    ny = min(dest(2, :));
    
%     find the farthest point in the positive y direction
    px = max(dest(1, :));
    py = max(dest(2, :));
    
    [r, c, ~] = size(I1T)
    [i2r, i2c, ~] = size(im2);
    fprintf('ny %f nx %f i2r %f i2c %f\n',ny, nx, i2r, i2c);

    compositeRows = 0;
    compositeCols = 0;
    
    if ny < 0 && py < i2r
        compositeRows = r + i2r - floor(abs(py))+2;
    elseif ny < 0 && py > i2r
        compositeRows = r+2;
    else
        compositeRows = r + i2r - floor(abs(nx))+2;
    end;
    compositeCols = c + i2c - floor(abs(px))+2;
    
    composite1 = zeros([compositeRows, compositeCols, 3]);
    composite2 = zeros([compositeRows, compositeCols, 3]);
    if ny < 0
        composite1(1:r, 1:c, :) = I1T;
        composite2(ceil(abs(ny))+1:ceil(abs(ny))+i2r, ...
            ceil(abs(nx))+2:ceil(abs(nx))+i2c+1, :) = im2;
    else
        composite1(ceil(abs(ny))-1:ceil(abs(py)), 1:c, :) = I1T;
        composite2(1:i2r, ...
            ceil(abs(nx))+2:ceil(abs(nx))+i2c+1, :) = im2;
    end;
    stitchedImage = composite1 + composite2;
    overlap = composite1 & composite2;
    stitchedImage(overlap) = stitchedImage(overlap)/2;
    stitchedImage = uint8(stitchedImage);

end

