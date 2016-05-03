load Sequence3Homographies

Image_00a = imread('SEQUENCE3/Image_00a.png');
Image_04a = imread('SEQUENCE3/Image_04a.png');

p_00 = [316 290 1];
p_04 = Sequence3Homographies(4).H * p_00';

figure; imshow(Image_00a); impixelinfo; hold on;
plot(p_00(1), p_00(2), 'go');
figure; imshow(Image_04a); impixelinfo; hold on;
plot(p_04(1), p_04(2), 'go');