function [normCorr] = computeNormalizedCorrelation(A, B)
%COMPUTENORMALIZEDCORRELATION Summary of this function goes here
%   Detailed explanation goes here

    normA = cellfun(@norm, num2cell(A, 2));
    normB = cellfun(@norm, num2cell(B, 2));
    
    A = bsxfun(@rdivide, A, normA);
    B = bsxfun(@rdivide, B, normB);
    
    rA = size(A, 1);
    rB = size(B, 1);
    
    normCorr = zeros([rA, rB]);
    
    for i=1:1:rA
        tempDot = dot(repmat(A(i,:), rB,1), B, 2);
        normCorr(i, :) = tempDot(:);
    end;
end

