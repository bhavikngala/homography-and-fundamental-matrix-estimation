function [rows, cols, neighbourhoodSize] = ...
    detectFeaturesHarris(I, sigma, threshold, radius, displayFlag)
%DETECTFEATURES Summary of this function goes here
%   Detailed explanation goes here

% function used to detect features on a image
% TODO: should take type of features to detect as user input.
% For now perform SURF feature detection and return [rows, cols]

% ouput should return neighbourhood size along with keypoints
    
    [~, rows, cols] = harris(I, sigma, threshold, radius, displayFlag);
    neighbourhoodSize = 2 * radius + 1;

end

