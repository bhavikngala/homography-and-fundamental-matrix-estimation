% script computes homography between 2 images then stitched them

clear all;
close all;
% read images 
I1C = imread('./../data/part1/ledge/1.jpg');
I2C = imread('./../data/part1/ledge/2.jpg');
I1 = im2double(rgb2gray(I1C));
I2 = im2double(rgb2gray(I2C));

% equalize the histograms of the images
I1 = histeq(I1);
I2 = histeq(I2);
% mean1 = mean(I1(:)); std1 = std(I1(:));
% mean2 = mean(I2(:)); std2 = std(I2(:));
% avgmean = (mean1 + mean2)/2; avgstd = (std1 + std2)/2;

% step 1 - Detect feature points in both images.
[r1, c1, nhbhs1] = detectFeaturesHarris(I1, 1.618, 0.1, 5, 0);
[r2, c2, nhbhs2] = detectFeaturesHarris(I2, 1.618, 0.1, 5, 0);

% plotDescriptorPoints(I1, I2, r1, c1, r2, c2);

[featureNeighbourhood1, r1, c1] = extractFeatureNeighbourhood(I1, r1, ...
    c1, nhbhs1);
[featureNeighbourhood2, r2, c2] = extractFeatureNeighbourhood(I2, r2, ...
    c2, nhbhs2);

% step 3.b - compute normalized correlation 
normCorr = computeNormalizedCorrelation(featureNeighbourhood1, ...
    featureNeighbourhood2);

% step 4 - select top few hundred of descriptors with 
[topRow, topCol, topNormCorr] = getPutativeMatches(normCorr, 150, 95);
topRow = topRow';
topCol = topCol';

% step 4.a - plot putative matches
plotPutativeMatches(I1, I2, r1, c1, r2, c2, topRow, topCol);

% step 5 - compute H using ransac
ransacIterations = 500;
threshold = 1;

[H, optimalNumInliers, optimalConsensusXY, optimalConsensusXYPrime, ...
    optimalSampleSpace, optimalInlierResidue] = ransac([c1(topRow), ...
    r1(topRow)], [c2(topCol), r2(topCol)], threshold, ransacIterations);

plotPutativeMatches(I1, I2, optimalConsensusXY(:,2), ....
    optimalConsensusXY(:,1), optimalConsensusXYPrime(:,2), ...
    optimalConsensusXYPrime(:,1), [1:1:size(optimalConsensusXY, 1)] ,...
    [1:1:size(optimalConsensusXY, 1)]);

stitchedImage = stitchImagesBasedOnHomography(I1C, I2C, H);
figure; imshow(stitchedImage);