function [F, optimalNumInliers, optimalConsensusXY, ...
    optimalConsensusXYPrime, optimalSampleSpace, optimalInlierResidue] ...
    = ransac(xy, xyprime, threshold, numIterations)
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

    optimalNumInliers = 0;
    optimalConsensusXY = zeros([8, 2]);
    optimalConsensusXYPrime = zeros([8, 2]);
    optimalSampleSpace = zeros([1, 8]);
    optimalInlierResidue = 0;

    for i=1:1:numIterations
%         step 1
        sampleSpace = randperm(size(xy, 1), 8);
%         step 2
        sampleF = fitFundamentalMatrix(xy(sampleSpace, :), ...
            xyprime(sampleSpace, :), 1);
%         step 3
        [numInliers, ~, sampleConsensusXY, sampleConsensusXYPrime, ...
            sampleInlierResidue] = ransacVoting( ...
            xy(setdiff(1:size(xy,1), sampleSpace), :), ...
            xyprime(setdiff(1:size(xyprime,1), sampleSpace), :), ...
            sampleF, ...
            threshold);
%         step 4
        if numInliers > optimalNumInliers
            optimalNumInliers = numInliers;
            optimalConsensusXY = sampleConsensusXY;
            optimalConsensusXYPrime = sampleConsensusXYPrime;
            optimalSampleSpace = sampleSpace;
            optimalInlierResidue = sampleInlierResidue;
        end;
    end;
%     step 5
    F = fitFundamentalMatrix(...
        cat(1, optimalConsensusXY, xy(optimalSampleSpace, :)), ...
        cat(1, optimalConsensusXYPrime, xyprime(optimalSampleSpace, :)),...
        1);
    
end