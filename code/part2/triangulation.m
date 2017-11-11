close all;
clear all;

I1 = imread('./../data/part2/house1.jpg');
I2 = imread('./../data/part2/house2.jpg');

% load the matching pairs
matches = load('./../data/part2/house_matches.txt'); 

% load camera matrices
P = load('./../data/part2/house1_camera.txt');
Pprime = load('./../data/part2/house2_camera.txt');

C1Centre = -1 * (P(:, 1:3)' * P(:, 4));
C2Centre = -1 * (Pprime(:, 1:3)' * Pprime(:, 4));

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
plot3(C1Centre(1), C1Centre(2), C1Centre(3), '*r');
plot3(C2Centre(1), C2Centre(2), C2Centre(3), '*r');
grid on;