close all;

% histogram equalization
I1 = im2double(rgb2gray(imread('./../data/part1/uttower/left.jpg')));
figure;
subplot(2, 2, 1);
imshow(I1); title('I1');

HE1 = histeq(I1);
subplot(2, 2, 3);
imshow(HE1); title('HE1');

I2 = im2double(rgb2gray(imread('./../data/part1/uttower/right.jpg')));
subplot(2, 2, 2);
imshow(I2); title('I2');

HE2 = histeq(I2);
subplot(2, 2, 4);
imshow(HE2); title('HE2');

% pixel normalization
min1 = min(I1(:)); min2 = min(I2(:));
max1 = max(I1(:)); max2 = min(I2(:));
avgMin = (min1 + min2)/2; avgMax = (max1 + max2)/2;
avgMinMax = (avgMin + avgMax)/2;
I1 = I1 ./ avgMinMax;
I2 = I2 ./ avgMinMax;
figure; subplot(2, 2, 1); imshow(I1); title('PN I1');
subplot(2, 2, 3); imshow(I2); title('PN I2');

min1 = min(HE1(:)); min2 = min(HE2(:));
max1 = max(HE1(:)); max2 = min(HE2(:));
avgMin = (min1 + min2)/2; avgMax = (max1 + max2)/2;
avgMinMax = (avgMin + avgMax)/2;
HE1 = HE1 ./ avgMinMax;
HE2 = HE2 ./ avgMinMax;
subplot(2, 2, 2); imshow(HE1); title('PN HE1');
subplot(2, 2, 4); imshow(HE2); title('PN HE2');