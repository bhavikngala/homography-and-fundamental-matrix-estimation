function [S, U, minEigenValue, H] = computeHomographyMatrix(xy, xyprime)
%COMPUTEHOMOGRAPHYMATRIX Summary of this function goes here
%   Detailed explanation goes here
    r = size(xy, 1);
    A = zeros([2 * r, 9]);
    
    expand = @(A) feval(@(x)x{:}, num2cell(A));
    
%     enforcing unit vector constraint
%     construct matrix A, size 2Nx9
    pointsIndex = 1;
    for i=1:2: 2 * r
        [x, y] = expand(xy(pointsIndex, :));
        [xprime, yprime] = expand(xyprime(pointsIndex, :));
        
        A(i, :) = [x, y, 1, 0, 0, 0, ...
                   (-1*(x * xprime)), (-1*(y * xprime)), (-1 * xprime)];
        A(i+1, :) = [0, 0, 0, x, y, 1, ...
                   (-1*(x * yprime)), (-1*(y * yprime)), (-1 * yprime)];
        pointsIndex = pointsIndex + 1;
    end;
    A

%     compute A.T * A
    ATA = A' * A;
%     compute SVD
    [U, S, ~] = svd(ATA);
%     find column number associated with min eigen value
    [minEigenValue, vectorColumn] = min(S(find(S)));
%     form H from that column in U
    H = reshape(U(:, vectorColumn), [3 3])';
end

