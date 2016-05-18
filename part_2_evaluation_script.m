%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB 4 of Visual Perception: SIFT               %
% Authors: Rodrigo Daudt and Jose Bernal         %
% Date: 21-04-2016                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;

util = Utilities;

noises = {'a', 'b', 'c', 'd'};
colors = {'r', 'b', 'g', 'c'};

%% Evaluate Sequence 1
load Sequence1Homographies

I1 = imread('SEQUENCE1/Image_00a.png');
I1 = single(rgb2gray(I1));

figure(1); hold on; grid on;
title('Accuracy of SIFT in Seq. 1');
xlabel('Sequence'); ylabel('Percentage of correct matches');
xlim([1 size(Sequence1Homographies, 2)]); ylim([0.7 1]);

for noise = 1 : length(noises)
    results = zeros(size(Sequence1Homographies, 2), 1);
    for i = 1 : size(Sequence1Homographies, 2)
        I2 = imread(strcat('SEQUENCE1/Image_', num2str(i,'%.2u'), noises{noise},'.png'));
        I2 = single(rgb2gray(I2));

        results(i, :) = util.evaluate_normal_sift(I1, I2, Sequence1Homographies(i).H);
    end

    plot(1:size(Sequence1Homographies, 2), results(:, 1), colors{noise});
end
legend('No noise', 'N(0, 3)', 'N(0, 6)', 'N(0, 18)', 'Location', 'southeast');

%% Evaluate Sequence 2
load Sequence2Homographies

I1 = imread('SEQUENCE2/Image_00a.png');
I1 = single(rgb2gray(I1));

figure(2); hold on; grid on;
title('Accuracy of SIFT in Seq. 2');
xlabel('Sequence'); ylabel('Percentage of correct matches');
xlim([1 size(Sequence2Homographies, 2)]); ylim([0.7 1]);

for noise = 1 : length(noises)
    results = zeros(size(Sequence2Homographies, 2), 1);
    for i = 1 : size(Sequence2Homographies, 2)
        I2 = imread(strcat('SEQUENCE2/Image_', num2str(i,'%.2u'), noises{noise},'.png'));
        I2 = single(rgb2gray(I2));

        results(i, :) = util.evaluate_normal_sift(I1, I2, Sequence2Homographies(i).H);
    end

    plot(1:size(Sequence2Homographies, 2), results(:, 1), colors{noise});
end
legend('No noise', 'N(0, 3)', 'N(0, 6)', 'N(0, 18)', 'Location', 'southeast');

%% Evaluate sequence 3
load Sequence3Homographies

I1 = imread('SEQUENCE3/Image_00a.png');
I1 = single(rgb2gray(I1));

figure(3); hold on; grid on;
title('Accuracy of SIFT in Seq. 3');
xlabel('Sequence'); ylabel('Percentage of correct matches');
xlim([1 size(Sequence3Homographies, 2)]); ylim([0.7 1]);
set(gca, 'xTickLabel', {'-45','-40','-35','-30','-25','-20','-15','-10', '-5', '5', '10', '15', '20', '25', '30', '35', '40', '45'});

for noise = 1 : length(noises)
    results = zeros(size(Sequence3Homographies, 2), 1);
    for i = 1 : size(Sequence3Homographies, 2)
        I2 = imread(strcat('SEQUENCE3/Image_', num2str(i,'%.2u'), noises{noise}, '.png'));
        I2 = single(rgb2gray(I2));

        results(i, :) = util.evaluate_normal_sift(I1, I2, Sequence3Homographies(i).H);
    end

    plot(1:size(Sequence3Homographies, 2), results(:, 1), colors{noise});
end
legend('No noise', 'N(0, 3)', 'N(0, 6)', 'N(0, 18)', 'Location', 'southeast');