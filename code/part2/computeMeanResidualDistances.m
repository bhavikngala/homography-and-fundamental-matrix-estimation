function [meanResidualAlgebraicDistances, meanResidualGeometricDistances...
    ] = computeMeanResidualDistances(xy, xyprime, F)
%COMPUTEMEANRESIDUALDISTANCES Summary of this function goes here
%   Detailed explanation goes here

%     reference: lec16 epipolar geometry - slide 32

    xy = [xy, ones(size(xy, 1))];
    xyprime = [xyprime, ones(size(xyprime, 1))];
      
%     minimizing sum of squared algebraic distances between points xyprime
%     and epipolar lines Fxy (or points xy and epipolar lines F'xyprime)
    meanResidualAlgebraicDistances = avg((xyprime * F * xy').^2);
    
%     calculate epipolar lines
    leftEpipoleLines = (F' * xyprime')';
    rightEpipoleLines = (F * xy')';
    
%     compute |Am + Bn + c|
    leftDotProduct = abs(dot(xy, leftEpipoleLines, 2));
    rightDotProduct = abs(dot(xyprime, rightEpipoleLines, 2));
%     compute sqrt(A^2 + B^2)
    leftGDDeno = leftEpipoleLines(:, 1).^2 + leftEpipoleLines(:, 2).^2;
    rightGDDeno = rightEpipoleLines(:, 1).^2 + rightEpipoleLines(:, 2).^2;
%     compute geometric distance avg
    meanResidualGeometricDistances = ...
        avg(bsxfun(@rdivide, leftDotProduct, leftGDDeno) + ...
            bsxfun(@rdivide, rightDotProduct, rightGDDeno));
    
end

