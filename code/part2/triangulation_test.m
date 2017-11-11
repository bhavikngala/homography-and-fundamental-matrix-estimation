close all;

% triangulates the points in 3D space and plots them

house1 = './../data/part2/house1.jpg';
house2 = './../data/part2/house2.jpg';
houseMatches = './../data/part2/house_matches.txt';

library1 = './../data/part2/library1.jpg';
library2 = './../data/part2/library2.jpg';
libraryMatches = './../data/part2/library_matches.txt';

% load camera matrices
P = './../data/part2/house1_camera.txt';
Pprime = './../data/part2/house2_camera.txt';

figure; triangulate(house1, house2, houseMatches, P, Pprime);
title('house');
figure; triangulate(library1, library2, libraryMatches, P, Pprime);
title('library');