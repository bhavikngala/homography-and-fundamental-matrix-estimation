function [F] = fitFundamentalMatrixunnormalized(xy, xyprime)
%FITFUNDAMENTALMATRIXUNNORMALIZED Summary of this function goes here
%   Detailed explanation goes here
    r = size(xy, 1);
    A = zeros(r, 9);
    
    expand = @(A) feval(@(x)x{:}, num2cell(A));
    
%     enforcing unit norm constraint
%     construct matrix A, size rx9
    for i = 1:1:r
        [x, y] = expand(xy(i, :));
        [xprime, yprime] = expand(xyprime(i, :));
        
        A(i, :) = [ x*xprime, x*yprime, x, y*xprime, y*yprime, y, ...
                    xprime, yprime, 1];
    end;
    
%     compute A.T * A
    ATA = A' * A;
%     compute SVD
    [U, S, ~] = svd(ATA);
%     find column number associated with min eigen value
    [~, vectorColumn] = min(diag(S));
%     form H from that column in U
    F = reshape(U(:, vectorColumn), [3, 3])';
%     enfornce rank 2 constraint on F
    [U, S, V] = svd(F);
%     set smalled element in S to zero
    S(find(min(S(:)))) = 0;
%     recompute F: F = U*S*V'
    F = U * S * V';
end

