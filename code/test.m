close all;

% read images 
I1 = rgb2gray(imread('./../data/part1/uttower/left.jpg'));
I2 = rgb2gray(imread('./../data/part1/uttower/right.jpg'));

% step 1 - Detect feature points in both images. You can use the Harris 
% corner detector code harris.m that we provide or the blob detector you 
% have developed as part of HW 2.
% harris feature detection
% TODO: harris is not scale invariant
% try to implement SIFT for scale invariance
[r1, c1, nhbhs1] = detectFeaturesHarris(I1, 1.618, 2000, 3, 1);
[r2, c2, nhbhs2] = detectFeaturesHarris(I2, 1.618, 2000, 3, 1);

% step 2 - Extract local neighborhoods around every keypoint in both 
% images, and form descriptors simply by flattening" the pixel values in 
% each neighborhood to one-dimensional vectors. Experiment with different 
% neighborhood sizes to see which one works the best. If you're using your 
% Laplacian detector, use the detected feature scales to define the 
% neighborhood scales.

featureNeighbourhood1 = extractFeatureNeighbourhood(I1, r1, c1, nhbhs1);
featureNeighbourhood2 = extractFeatureNeighbourhood(I2, r2, c2, nhbhs2);