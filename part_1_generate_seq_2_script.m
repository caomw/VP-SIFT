%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%% Description: VP Lab 4 SIFT                                          %%%
%%%              Part 1 - Generate sequence 2                           %%%
%%% Authors: Rodrigo Daubt and Jose Bernal                              %%%
%%% Date: 21-04-2016                                                    %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

%% Load image

I = im2double(imread('Image_base_050.jpg'));
% figure;
% imshow(I);

% Center coordinates
c = [2300; 2300; 1];
region_size = [500; 750; 0];
l = region_size/2;
top_left = c - region_size/2;

crop = I(top_left(1) : (top_left(1) + region_size(1)), top_left(2) : (top_left(2) + region_size(2)), :);
large_crop = I((c(1) - 750) : (c(1) + 750), (c(2) - 750) : (c(2) + 750), :);
% figure;
% imshow(crop);
% imwrite(crop,'Image_00a.png');
% imwrite(large_crop,'large_crop.png');

%% Zoom
for i = 1:9
    zoom = 1.05 + i * 0.05;
    A = [zoom 0 0;0 zoom 0;0 0 1];
    Sequence2Homographies(i).H = [zoom 0 ((1 - zoom) * l(2)); 0 zoom ((1 - zoom) * l(1)); 0 0 1];
    transf = affine2d(A);
    [zoomed_image, ~] = imwarp(large_crop, transf);
    s = size(zoomed_image);
    c = round(s(1:2)/2); % center
    zoomed_image = zoomed_image((c(1) - l(1)) : (c(1) + l(1)), (c(2) - l(2)) : (c(2) + l(2)), :);
    
%     figure;
%     imshow(zoomed_image);
    imwrite(image, strcat('SEQUENCE3/Image_', num2str(i,'%.2u'), 'a.png'));
    imwrite(imnoise(image, 'gaussian', 0, (3/255)^2), strcat('SEQUENCE2/Image_', num2str(i,'%.2u'), 'b.png'));
    imwrite(imnoise(image, 'gaussian', 0, (6/255)^2), strcat('SEQUENCE2/Image_', num2str(i,'%.2u'), 'c.png'));
    imwrite(imnoise(image, 'gaussian', 0, (18/255)^2), strcat('SEQUENCE2/Image_', num2str(i,'%.2u'), 'd.png'));
end

save('Sequence2Homographies.mat','Sequence2Homographies');