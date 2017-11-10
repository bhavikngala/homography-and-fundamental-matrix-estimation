function [threeDCoords] = compute3DCoordinate(xy, xyprime, P, Pprime)
%COMPUTE3DCOORDINATE Summary of this function goes here
%   Detailed explanation goes here
    threeDCoords = zeros(size(xy, 1), 4);
    
%     inline function expand borrowed from the internet
    expand = @(A) feval(@(x)x{:}, num2cell(A));
    
    for  i=1:1:size(xy, 1)
        P1 = P(1,:);
        P2 = P(2,:);
        P3 = P(3,:);
        Pprime1 = Pprime(1,:);
        Pprime2 = Pprime(2,:);
        Pprime3 = Pprime(3,:);
        
        [x, y] = expand(xy(i, :));
        [xprime, yprime] = expand(xyprime(i, :));
        
        A = [x     *P3      - P1; ...
             y     *P3      - P2; ...
             xprime*Pprime3 - Pprime1; ...
             yprime*Pprime3 - Pprime2];
         
         [U, S, ~] = svd(A' * A);
         [~, vectorColumn] = min(diag(S));
         X = (U(:, vectorColumn))';
         X(1:3) = X(1:3) ./ X(1, 4);
         threeDCoords(i, :) = X;
    end;

end

