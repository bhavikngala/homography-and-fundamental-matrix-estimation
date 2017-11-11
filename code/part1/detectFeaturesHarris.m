function [rows, cols, neighbourhoodSize] = ...
    detectFeaturesHarris(I, sigma, threshold, radius, displayFlag)
%DETECTFEATURES Summary of this function goes here
%   Detailed explanation goes here

% function used to detect features on a image

% ouput should return neighbourhood size along with keypoints
    
    [~, rows, cols] = harris(I, sigma, threshold, radius, displayFlag);
    neighbourhoodSize = 5 * (2 * radius + 1);

end

