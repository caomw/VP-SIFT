%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB 4 of Visual Perception: SIFT               %
% Authors: Rodrigo Daudt and Jose Bernal         %
% Date: 21-04-2016                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

load Sequence1Homographies

Image_00a = imread('SEQUENCE1/Image_00a.png');
Image_01a = imread('SEQUENCE1/Image_01a.png');

p_00 = [316 290 1];
p_04 = Sequence1Homographies(1).H * p_00';
p_04 = p_04 / p_04(end);

figure; imshow(Image_00a); impixelinfo; hold on;
plot(p_00(1), p_00(2), 'go');
figure; imshow(Image_01a); impixelinfo; hold on;
plot(p_04(1), p_04(2), 'go');