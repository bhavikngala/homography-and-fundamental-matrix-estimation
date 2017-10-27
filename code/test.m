close all;

% read images 
I1 = rgb2gray(imdouble(imread('./../data/')));
I2 = rgb2gray(imdouble(imread('./../data')));

% step 1 - feature extraction