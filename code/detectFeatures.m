function detectFeatures(I)
%DETECTFEATURES Summary of this function goes here
%   Detailed explanation goes here

% function used to detect features on a image
% TODO: should take type of features to detect as user input.
% For now perform SURF feature detection and return [rows, cols]
    
    surfPoints = detectSURFFeatures(I);
    figure;
    imshow(I);
    hold on;
    plot(surfPoints.selectStrongest(1000000));

end

