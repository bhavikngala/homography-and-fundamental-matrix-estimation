function [F] = fitFundamentalMatrix(xy, xyprime, normalizeFlag)
%FITFUNDAMENTALMATRIXUNNORMALIZED Summary of this function goes here
%   Detailed explanation goes here
    r = size(xy, 1);
    A = zeros(r, 9);
    
    if normalizeFlag
        Txy = computeCoordinateNormalizingMatrix(xy);
        Txyprime = computeCoordinateNormalizingMatrix(xyprime);
    end;
    
    expand = @(A) feval(@(x)x{:}, num2cell(A));
    
%     enforcing unit norm constraint
%     construct matrix A, size rx9
    for i = 1:1:r
        [x, y] = expand(xy(i, :));
        [xprime, yprime] = expand(xyprime(i, :));
        
        if normalizeFlag
            [x, y, ~] = expand(Txy * [x; y; 1]);
            [xprime, yprime, ~] = expand(Txyprime * [xprime; yprime; 1]);
        end;
        
        A(i, :) = [ x*xprime, x*yprime, x, y*xprime, y*yprime, y, ...
                    xprime, yprime, 1];
    end;
    
%     compute A.T * A
%     ATA = A' * A;
%     compute SVD
    [U, S, V] = svd(A);
%     find column number associated with min eigen value
    [~, vectorColumn] = min(diag(S));
%     form H from that column in U
    F = reshape(V(:, vectorColumn), [3, 3]);
%     enfornce rank 2 constraint on F
    [U, S, V] = svd(F);
%     set smalled element in S to zero
    [~, index] = min(diag(S));
    S(index, index) = 0;
%     recompute F: F = U*S*V'
    F = U * S * V';
    
    if normalizeFlag
        F = inv(Txyprime) * F * Txy;
    end;
end

