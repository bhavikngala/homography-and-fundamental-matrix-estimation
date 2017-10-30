function plotPutativeMatches(I1, I2, I1featureRows, I1featureCols, ...
    I2featureRows, I2featureCols, putativeRows, putativeCols)
%PLOTPUTATIVEMATCHES Summary of this function goes here
%   Detailed explanation goes here
    
    I = [I1, I2];
    figure;
    imshow(I);
    hold on;
    
    I1width = size(I1, 2);
    [pr, pc] = size(putativeRows)
    
    for i=1:1: pr * pc
        I1putative = putativeRows(i);
        I2putative = putativeCols(i);
        x1 = I1featureCols(I1putative);
        y1 = I1featureRows(I1putative);
        x2 = I2featureCols(I2putative) + I1width;
        y2 = I2featureRows(I2putative);
        
        plot([x2, x1], [y2, y1], 'Color', 'r', 'linewidth', 1);
    end;

end

