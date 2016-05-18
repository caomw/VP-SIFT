%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB 4 of Visual Perception: SIFT               %
% Authors: Rodrigo Daudt and Jose Bernal         %
% Date: 21-04-2016                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

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
c_crop = l + 1;
large_crop = I((c(1)-750):(c(1)+750),(c(2)-750):(c(2)+750),:);
c_large = [751;751;1];

%% Projective Homographies

% amount of deformation -> 1 = no deformation
z = [1.1  1.2  1.3  1.4  1    1    1    1;
     1    1    1    1    1.1  1.2  1.3  1.4];

% centre offsets for ref points - "8-neighbourhood" of centre
c_os = [l(1)  l(1)  -l(1)  -l(1);
        l(2)  -l(2)  -l(2)  l(2)];

% Reference points in crop and large_crop
ref_crop = ones(3,4);
for i = 1:2
    ref_crop(i,:) = c_os(i,:) + c_crop(i);
end

% Fix x and y because reasons
ref_crop = [ref_crop(2,:);ref_crop(1,:);ref_crop(3,:)];

p_crop = ones(3,4);
ref = imref2d(size(crop));

% For each case
for i = 1:8
    index = i;

    zx1 = z(1,i);
    zx2 = z(2,i);
    zx = (zx1 + zx2)/2;
    zy1 = 1;
    zy2 = 1;
    zy = (zy1 + zy2)/2;

    % Offset
    k = [zy1  zy2  zy2  zy1;
         zx1  zx1  zx2  zx2];
    os = k.*c_os;

    % Deformation points
    for ii = 1:2
        p_crop(ii,:) = os(ii,:) + c_crop(ii);
    end
%     figure;scatter(p_crop(1,:),p_crop(2,:))

    % Fix x and y because reasons
    p_crop = [p_crop(2,:);p_crop(1,:);p_crop(3,:)];

    % Compute homography
    tform = fitgeotrans(ref_crop(1:2,:)',p_crop(1:2,:)','projective');
    H = tform.T';

    % Apply transformation and crop new image
    proj_image = imwarp(crop,tform,'OutputView',ref);
    figure;imshow(proj_image);size(proj_image)

    % Save images
    name = ['SEQUENCE1/Image_' num2str(index,'%.2u')];
    imwrite(proj_image,[name 'a.png']);
    imwrite(imnoise(proj_image,'gaussian',0,(3/255)^2),[name 'b.png']);
    imwrite(imnoise(proj_image,'gaussian',0,(6/255)^2),[name 'c.png']);
    imwrite(imnoise(proj_image,'gaussian',0,(18/255)^2),[name 'd.png']);

    % Save homography
    Sequence1Homographies(index).H = H;
end

% For each other case
for i = 1:8
    index = i + 8;

    zx1 = 1;
    zx2 = 1;
    zx = (zx1 + zx2)/2;
    zy1 = z(1,i);
    zy2 = z(2,i);
    zy = (zy1 + zy2)/2;

    % Offset
    k = [zy1  zy2  zy2  zy1;
         zx1  zx1  zx2  zx2];
    os = k.*c_os;

    % Deformation points
    for ii = 1:2
        p_crop(ii,:) = os(ii,:) + c_crop(ii);
    end
%     figure;scatter(p_crop(1,:),p_crop(2,:))

    % Fix x and y because reasons
    p_crop = [p_crop(2,:);p_crop(1,:);p_crop(3,:)];

    % Compute homography
    tform = fitgeotrans(ref_crop(1:2,:)',p_crop(1:2,:)','projective');
    H = tform.T';

    % Apply transformation and crop new image
    proj_image = imwarp(crop,tform,'OutputView',ref);
    figure;imshow(proj_image);size(proj_image)

    % Save images
    name = ['SEQUENCE1/Image_' num2str(index,'%.2u')];
    imwrite(proj_image,[name 'a.png']);
    imwrite(imnoise(proj_image,'gaussian',0,(3/255)^2),[name 'b.png']);
    imwrite(imnoise(proj_image,'gaussian',0,(6/255)^2),[name 'c.png']);
    imwrite(imnoise(proj_image,'gaussian',0,(18/255)^2),[name 'd.png']);

    % Save homography
    Sequence1Homographies(index).H = H;
end

% Save homographies
save('Sequence1Homographies.mat','Sequence1Homographies');

%% Test

i = 13;

%tform = fitgeotrans(ref_crop(1:2,:)',p_crop(1:2,:)','projective');
%ref = imref2d(size(crop));
proj_image = imread(['SEQUENCE1/Image_' num2str(i,'%.2u') 'a.png']);


H = Sequence1Homographies(i).H;
p = [320, 360, 1]';

figure(1);
imshow(crop);
hold on;
scatter(p(1), p(2), 'ro', 'linewidth', 3);

pause(0.2)

figure(2);
imshow(proj_image);
hold on;
p2 = H * p;
p2 = p2 / p2(end);
scatter(p2(1), p2(2), 'ro', 'linewidth', 3);