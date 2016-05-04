%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%% Description: VP Lab 4 SIFT                                          %%%
%%%              Part 2 - Evaluate SIFT                                 %%%
%%% Authors: Rodrigo Daubt and Jose Bernal                              %%%
%%% Date: 21-04-2016                                                    %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;

noises = {'a', 'b', 'c', 'd'};
colors = {'r', 'b', 'g', 'c'};
forms = {'x', '*', '+', '.'};

%% Evaluate Sequence 1
load Sequence1Homographies

I1 = imread('SEQUENCE1/Image_00a.png');

figure(1); hold on; grid on;
xlim([1 size(Sequence1Homographies, 2)]);

for noise = 1 : length(noises)
    results = zeros(size(Sequence1Homographies, 2), 1);
    for i = 1 : size(Sequence1Homographies, 2)
        str = num2str(i);
        if i < 10
            str = strcat('0', str);
        end
        I2 = imread(strcat('SEQUENCE1/Image_', str, noises{noise},'.png'));

        loc = evaluate_sift(I1, I2, Sequence1Homographies(i).H);

        results(i, :) = loc;
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
        str = num2str(i);
        if i < 10
            str = strcat('0', str);
        end
        I2 = imread(strcat('SEQUENCE2/Image_', str, noises{noise},'.png'));

        loc = evaluate_sift(I1, I2, Sequence2Homographies(i).H);

        results(i, :) = loc;
    end

    style = strcat(forms{noise}, '-', colors{noise});
    plot(1:size(Sequence2Homographies, 2), results(:, 1), style);
end

%% Evaluate sequence 3
load Sequence3Homographies

I1 = imread('SEQUENCE3/Image_00a.png');

figure(3); hold on; grid on;
xlim([1 size(Sequence3Homographies, 2)]);

results = zeros(size(Sequence3Homographies, 2), length(noises));
for noise = 1 : length(noises)
    for i = 1 : size(Sequence3Homographies, 2)
        str = num2str(i);
        if i < 10
            str = strcat('0', str);
        end
        I2 = imread(strcat('SEQUENCE3/Image_', str, noises{noise}, '.png'));

        results(i, noise) = evaluate_sift(I1, I2, Sequence3Homographies(i).H);
    end

    style = strcat(forms{noise}, '-', colors{noise});
    plot(1:size(Sequence3Homographies, 2), results(:, noise), style);
end