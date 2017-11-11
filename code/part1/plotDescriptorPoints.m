function plotDescriptorPoints(I1, I2, r1, c1, r2, c2)
%PLOTPUTATIVEMATCHES Summary of this function goes here
%   Detailed explanation goes here
%     function plots descriptor points on 2 images placed side by side
    
    I = [I1, I2];
    figure;
    imshow(I);
    hold on;
    
    I1width = size(I1, 2);
    
    [r, c] = size(r1);
    for i=1:1:r*c
        plot(c1, r1, 'm*');
    end;
    
    [r, c] = size(r2);
    for i=1:1: r*c
        plot(c2+I1width, r2, 'gx');
    end;

end

