close all;

% read images 
I1 = rgb2gray(imread('./../data/part1/uttower/left.jpg'));
I2 = rgb2gray(imread('./../data/part1/uttower/right.jpg'));

% step 1 - feature extraction
% harris feature detection
% TODO: harris is not scale invariant
% try to implement SIFT for scale invariance
[cim1, r1, c1] = harris(I1, 1.618, 2000, 3, 1);
[cim2, r2, c2] = harris(I2, 1.618, 2000, 3, 1);

