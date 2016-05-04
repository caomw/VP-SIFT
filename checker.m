load Sequence2Homographies

Image_00a = imread('SEQUENCE2/Image_00a.png');
Image_04a = imread('SEQUENCE2/Image_01a.png');

p_00 = [316 290 1];
p_04 = Sequence2Homographies(1).H * p_00';

figure; imshow(Image_00a); impixelinfo; hold on;
plot(p_00(1), p_00(2), 'go');
figure; imshow(Image_04a); impixelinfo; hold on;
plot(p_04(1), p_04(2), 'go');