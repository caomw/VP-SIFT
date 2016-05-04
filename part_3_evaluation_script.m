%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%% Description: VP Lab 4 SIFT                                          %%%
%%%              Part 3 - Comparison                                    %%%
%%% Authors: Rodrigo Daubt and Jose Bernal                              %%%
%%% Date: 21-04-2016                                                    %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

util = Utilities;

image1 = imread('SEQUENCE2/Image_00a.png');
image2 = imread('SEQUENCE2/Image_01a.png');

noises = {'a', 'b', 'c', 'd'};
colors = {'r', 'b', 'g', 'c'};
forms = {'x', '*', '+', '.'};

%% Evaluate Sequence 1
load Sequence1Homographies

I1 = imread('SEQUENCE1/Image_00a.png');

figure(1); hold on; grid on;
xlim([1 size(Sequence1Homographies, 2)]);

for noise = 1 : length(noises)
    results = zeros(size(Sequence1Homographies, 2), 2);
    for i = 1 : size(Sequence1Homographies, 2)
        I2 = imread(strcat('SEQUENCE1/Image_', num2str(i,'%.2u'), noises{noise},'.png'));

        loc1 = util.evaluate_normal_sift(I1, I2, Sequence1Homographies(i).H);
        loc2 = util.evaluate_sift_one_scale(I1, I2, Sequence1Homographies(i).H);

        results(i, 1) = loc1;
        results(i, 2) = loc2;
    end

    style = strcat(forms{noise}, '-', colors{noise});
    plot(1:size(Sequence1Homographies, 2), results(:, 1), style);
end

%% Evaluate Sequence 2
load Sequence2Homographies

I1 = imread('SEQUENCE2/Image_00a.png');

figure(2); hold on; grid on;
xlim([1 size(Sequence2Homographies, 2)]);

for noise = 1 : length(noises)
    results = zeros(size(Sequence2Homographies, 2), 1);
    for i = 1 : size(Sequence2Homographies, 2)
        I2 = imread(strcat('SEQUENCE2/Image_', num2str(i,'%.2u'), noises{noise},'.png'));

        loc1 = util.evaluate_normal_sift(I1, I2, Sequence1Homographies(i).H);
        loc2 = util.evaluate_sift_one_scale(I1, I2, Sequence1Homographies(i).H);

        results(i, 1) = loc1;
        results(i, 2) = loc2;
    end

    style = strcat(forms{noise}, '-', colors{noise});
    plot(1:size(Sequence2Homographies, 2), results(:, 1), style);
end

%% Evaluate sequence 3
load Sequence3Homographies

I1 = imread('SEQUENCE3/Image_00a.png');

figure(3); hold on; grid on;
xlim([1 size(Sequence3Homographies, 2)]);

for noise = 1 : length(noises)
    results = zeros(size(Sequence3Homographies, 2), 1);
    for i = 1 : size(Sequence3Homographies, 2)
        I2 = imread(strcat('SEQUENCE3/Image_', num2str(i,'%.2u'), noises{noise}, '.png'));

        loc1 = util.evaluate_normal_sift(I1, I2, Sequence1Homographies(i).H);
        loc2 = util.evaluate_sift_one_scale(I1, I2, Sequence1Homographies(i).H);

        results(i, 1) = loc1;
        results(i, 2) = loc2;
    end

    style = strcat(forms{noise}, '-', colors{noise});
    plot(1:size(Sequence3Homographies, 2), results(:, 1), style);
end