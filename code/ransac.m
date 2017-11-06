function [ output_args ] = ransac(allPoints, threshold, numIterations)
%RANSAC Summary of this function goes here
%   Detailed explanation goes here

%     step 1: Select a random subset of the original data hypothetical 
%     inliers.
%     step 2: A model is fitted to the set of hypothetical inliers.
%     step 3: All other data are then tested against the fitted model 
%     using some model specific loss function
%     step 4: The estimated model is reasonably good if sufficiently many 
%     points have been classified as part of the consensus set.
%     step 5: Afterwards, the model may be improved by reestimating it 
%     using all members of the consensus set.

    for i=1:1:numIterations
    end;

end