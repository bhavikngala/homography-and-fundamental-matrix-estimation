% computes fundamental matrix for pair of images, features are detected and
% matches are computed, RANSAC is ran on the matches to find optimal F

close all;
% read images 
I1 = im2double(rgb2gray(imread('./../data/part2/library1.jpg')));
I2 = im2double(rgb2gray(imread('./../data/part2/library2.jpg')));

I1 = histeq(I1);
I2 = histeq(I2);

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
[topRow, topCol, topNormCorr] = getPutativeMatches(normCorr, 50, 95);
topRow = topRow';
topCol = topCol';

% step 4.a - plot putative matches
% plotPutativeMatches(I1, I2, r1, c1, r2, c2, topRow, topCol);

% step 5 - compute H using ransac
ransacIterations = 1000;
threshold = 1;

[F, optimalNumInliers, optimalConsensusXY, optimalConsensusXYPrime, ...
    optimalSampleSpace, optimalInlierResidue] = ...
    ransac([c1(topRow), r1(topRow)],[c2(topCol), r2(topCol)], ...
    threshold, ransacIterations);

N = size(optimalConsensusXY, 1);
% F = fit_fundamental(matches); % this is a function that you should write
L = (F * [optimalConsensusXY ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [optimalConsensusXYPrime ones(N,1)],2);
closest_pt = optimalConsensusXYPrime - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
clf;
imshow(I2); hold on;
plot(optimalConsensusXYPrime(:, 1), optimalConsensusXYPrime(:,2), '+r');
line([optimalConsensusXYPrime(:, 1) closest_pt(:,1)]', ...
    [optimalConsensusXYPrime(:, 2) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');