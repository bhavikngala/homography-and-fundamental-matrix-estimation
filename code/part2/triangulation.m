close all;

I1 = imread('./../data/part2/house1.jpg');
I2 = imread('./../data/part2/house2.jpg');

% load the matching pairs
matches = load('./../data/part2/house_matches.txt'); 

% load camera matrices
P = load('./../data/part2/house1_camera.txt');
Pprime = load('./../data/part2/house2_camera.txt');

house3d = zeros(size(matches, 1), 3);

% compute 3d points
for i=1:1:size(matches, 1)
    house3d = compute3DCoordinate(matches(i, 1:2), matches(i, 3:4), ...
        P, Pprime);
end;

% plot 3d points
figure; plot3(house3d(1,:), house3d(12,:),  house3d(3,:));