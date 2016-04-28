% Ricard's email: rprados@atc.udg.edu
% VP Lab 4
% Daudt
% 21/04

% Generate Homography matrices

clear all
close all
clc

%% Load image

I = im2double(imread('Image_base_050.jpg'));
% figure;
% imshow(I);

% Center coordinates
c = [2300;2300;1];
region_size = [500;750;0];
l = region_size/2;
top_left = c - region_size/2;

crop = I(top_left(1):(top_left(1)+region_size(1)),top_left(2):(top_left(2)+region_size(2)),:);
large_crop = I((c(1)-750):(c(1)+750),(c(2)-750):(c(2)+750),:);
% figure;
% imshow(crop);
imwrite(crop,'Image_00a.png');
imwrite(large_crop,'large_crop.png');

%% Zoom

% Sequence2Homographies = cell(1,9);


for i = 1:9
    zoom = 1.05 + i*0.05;
    A = [zoom 0 0;0 zoom 0;0 0 1];
    Sequence2Homographies(i).H = [zoom 0 ((1-zoom)*l(1));0 zoom ((1-zoom)*l(2));0 0 1];
    transf = affine2d(A);
    [zoomed_image, ~] = imwarp(large_crop,transf);
    s = size(zoomed_image);
    c = round(s(1:2)/2); % center
    zoomed_image = zoomed_image((c(1)-l(1)):(c(1)+l(1)),(c(2)-l(2)):(c(2)+l(2)),:);
    
%     figure;
%     imshow(zoomed_image);

    imwrite(zoomed_image,['SEQUENCE2/Image_0' num2str(i) 'a.png']);
    imwrite(imnoise(zoomed_image,'gaussian',0,(3/255)^2),['SEQUENCE2/Image_0' num2str(i) 'b.png']);
    imwrite(imnoise(zoomed_image,'gaussian',0,(6/255)^2),['SEQUENCE2/Image_0' num2str(i) 'c.png']);
    imwrite(imnoise(zoomed_image,'gaussian',0,(18/255)^2),['SEQUENCE2/Image_0' num2str(i) 'd.png']);
    
end

save('Sequence2Homographies.mat','Sequence2Homographies');

%% Test

H = Sequence2Homographies(9).H;
p = [260,320,1]';

figure(1);
imshow(crop);
hold on;
scatter(p(2),p(1),'ro','linewidth',3);

pause(0.2)

figure(2);
imshow(zoomed_image);
hold on;
p2 = H*p;
scatter(p2(2),p2(1),'ro','linewidth',3);

%%

for i = 1:4
    zr = (0.25 - i*0.1)/1000;
    A = [1 0 zr;0 1 -zr;0 0 1]
%     Sequence2Homographies(i).H = [zoom 0 ((1-zoom)*l(1));0 zoom ((1-zoom)*l(2));0 0 1];
%     transf = projective2d(A);
    transf = maketform('projective',A);
    [proj_image, ~] = imtransform(large_crop,transf);
    s = size(proj_image);
    c = round(s(1:2)/2); % center
%     proj_image = proj_image((c(1)-l(1)):(c(1)+l(1)),(c(2)-l(2)):(c(2)+l(2)),:);
    
    figure;
    imshow(proj_image);

%     imwrite(zoomed_image,['SEQUENCE2/Image_0' num2str(i) 'a.png']);
%     imwrite(imnoise(zoomed_image,'gaussian',0,(3/255)^2),['SEQUENCE2/Image_0' num2str(i) 'b.png']);
%     imwrite(imnoise(zoomed_image,'gaussian',0,(6/255)^2),['SEQUENCE2/Image_0' num2str(i) 'c.png']);
%     imwrite(imnoise(zoomed_image,'gaussian',0,(18/255)^2),['SEQUENCE2/Image_0' num2str(i) 'd.png']);
    
end
























