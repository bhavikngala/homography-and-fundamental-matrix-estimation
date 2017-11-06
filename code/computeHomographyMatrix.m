function [S, U, minEigenValue, H] = computeHomographyMatrix(xy, xydash)
%COMPUTEHOMOGRAPHYMATRIX Summary of this function goes here
%   Detailed explanation goes here
    r = size(xy, 1);
    A = zereos([2 * r, 9]);
    
%     enforcing unit vector constraint
%     construct matrix A, size 2Nx9
    pointsIndex = 1;
    for i=1:2: 2 * r
        A(i, :) = [xy(pointsIndex, 1), xy(pointsIndex, 2), ...
                   1, 0, 0, 0, ...
                   (-1*(xy(pointsIndex, 1)*xydash(pointsIndex, 1))), ...
                   (-1*(xy(pointsIndex, 2)*xydash(pointsIndex, 1))), ...
                   (-1 * xy(pointsIndex, 1))];
        A(i+1, :) = [0, 0, 0, ...
                   xy(pointsIndex, 1), xy(pointsIndex, 2), ...
                   1, ...
                   (-1*(xy(pointsIndex, 1)*xydash(pointsIndex, 2))), ...
                   (-1*(xy(pointsIndex, 2)*xydash(pointsIndex, 2))), ...
                   (-1 * xy(pointsIndex, 2))];
        pointsIndex = pointsIndex + 1;
    end;

%     compute A.T * A
    ATA = A' * A;
%     compute SVD
    [U, S, ~] = svd(ATA);
%     find column number associated with min eigen value
    [minEigenValue, vectorColumn] = min(S(find(S)));
%     form H from that column in U
    H = reshape(U(:, vectorColumn), [3 3])';
end

