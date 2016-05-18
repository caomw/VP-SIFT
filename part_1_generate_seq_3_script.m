%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB 4 of Visual Perception: SIFT               %
% Authors: Rodrigo Daudt and Jose Bernal         %
% Date: 21-04-2016                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

image = im2double(imread('Image_base_050.jpg'));

image_container = [1500 1500];
image_size = [500 750];
c = [2300 2300 1]';

image_piece = image(c(1)-floor(image_container(1)/2):c(1)+ceil(image_container(1)/2), c(2)-floor(image_container(2)/2):c(2)+ceil(image_container(2)/2), :);

range = [-45 : 5 : -5, 5 : 5 : 45];

trans_idx = 1;
for i = range
    theta = i / 180 * pi;
    T = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
    tform = affine2d(T);
    [transformed_image, ~] = imwarp(image_piece, tform);
    
    new_center = round(size(transformed_image) / 2);
    range_x = new_center(1)-floor(image_size(1)/2) : new_center(1)+ceil(image_size(1)/2);
    range_y = new_center(2)-floor(image_size(2)/2) : new_center(2)+ceil(image_size(2)/2);
    image = transformed_image(range_x, range_y, :);
    %figure(); imshow(image)
    
    l1 = size(image, 2) / 2;
    l2 = size(image, 1) / 2;
    
    T = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
    T(1, 3) = -l1*cos(theta) - l2*sin(theta) + l1;
    T(2, 3) = l1*sin(theta) - l2*cos(theta) + l2;
    Sequence3Homographies(trans_idx).H = T;
    
    %saving the images
    imwrite(image, strcat('SEQUENCE3/Image_', num2str(i,'%.2u'), 'a.png'));
    imwrite(imnoise(image, 'gaussian', 0, (3/255)^2), strcat('SEQUENCE3/Image_', num2str(i,'%.2u'), 'b.png'));
    imwrite(imnoise(image, 'gaussian', 0, (6/255)^2), strcat('SEQUENCE3/Image_', num2str(i,'%.2u'), 'c.png'));
    imwrite(imnoise(image, 'gaussian', 0, (18/255)^2), strcat('SEQUENCE3/Image_', num2str(i,'%.2u'), 'd.png'));
    
    trans_idx = trans_idx + 1;
end

save('Sequence3Homographies.mat', 'Sequence3Homographies');