function triangulate(I1path, I2path, groundtruth, cam1, cam2)
%TRIANGULATE Summary of this function goes here
%   Detailed explanation goes here
%   compute camera centres
%   computes 3D coordinates of image points
%   plots the points in 3D plot

    I1 = imread(I1path);
    I2 = imread(I2path);

    % load the matching pairs
    matches = load(groundtruth); 

    % load camera matrices
    P = load(cam1);
    Pprime = load(cam2);

    [~, ~, V] = svd(P);
    C1Centre = V(:, end);
    C1Centre = C1Centre(:) ./ C1Centre(4);

    [~, ~, V] = svd(Pprime);
    C2Centre = V(:, end);
    C2Centre = C2Centre(:) ./ C2Centre(4);

    house3d = zeros(size(matches, 1), 4);

    % compute 3d points
    for i=1:1:size(matches, 1)
        house3d(i, :) = compute3DCoordinate(matches(i, 1:2), matches(i, 3:4), ...
            P, Pprime);
    end;

    % plot 3d points
    % plot3(house3d(:, 1), house3d(:, 2), house3d(:, 3));
    axis equal; 
    plot3(house3d(:,1), house3d(:,2), house3d(:,3), '.b');
    hold on;
    plot3(C1Centre(1), C1Centre(2), C1Centre(3), '*y');
    plot3(C2Centre(1), C2Centre(2), C2Centre(3), '*r');
    grid on;

end

