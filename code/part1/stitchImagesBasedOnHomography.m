function [stitchedImage] = stitchImagesBasedOnHomography(im1, im2, H)
%STITCHIMAGESBASEDONHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here
    [y, x, ~] = size(im2);
    source = [1 1 x x; ...
              1 y 1 y; ...
              1 1 1 1];
    dest = H * source;
    dest = bsxfun(@rdivide, dest, dest(3, :));
    
    disp('source'); source
    disp('dest'); dest
    
    T1 = maketform('projective', source(1:2, :)', dest(1:2, :)');
    [I1T, xdata, ydata] = imtransform(im1, T1, 'bicubic');
    figure; imshow(im1);
    figure; imshow(I1T);
    figure; imshow(im2);
    
%     find the farthest point in the negative x direction
    nx = min(dest(1, :));
    ny = min(dest(2, :));
    
%     find the farthest point in the positive y direction
    px = ceil(max(dest(1, :)));
    py = ceil(max(dest(2, :)));
    
    [r, c, ~] = size(I1T);
    [i2r, i2c, ~] = size(im2);
    fprintf('ny %f nx %f i2r %f i2c %f\n',ny, nx, i2r, i2c);

    compositeRows = 0;
    compositeCols = 0;
    
    if ny < 0 && py > i2r
        compositeRows = r;
    else
        compositeRows = ceil(abs(ny)) + i2r + 1;
    end;
    if nx < 0 && px > i2c
        compositeCols = c;
    else
        compositeCols = ceil(abs(nx)) + i2c + 1;
    end;
    
    nx = ceil(abs(nx));
    ny = ceil(abs(ny));
    
    composite1 = zeros([compositeRows, compositeCols, 3]);
    composite2 = zeros([compositeRows, compositeCols, 3]);
    
    [r, c, ~] = size(I1T);
    composite1(1:r, 1:c, :) = I1T;
    composite2(ny + 2:ny + i2r + 1, nx + 2:nx + i2c + 1, :) = im2;
    disp('size composite1');size(composite1)
    disp('size composite2');size(composite2)
    stitchedImage = composite1 + composite2;
    overlap = composite1 & composite2;
    stitchedImage(overlap) = stitchedImage(overlap)/2;
    stitchedImage = uint8(stitchedImage);
%     figure; imshow(stitchedImage);

end

