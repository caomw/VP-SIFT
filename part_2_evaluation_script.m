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
xlabel('Projection'); ylabel('Percentage of correct matches');
xlim([1 size(Sequence1Homographies, 2)]); ylim([0.7 1]);
set(gca, 'xTick', 1:16);
set(gca, 'xTickLabel', {'110%','120%','130', '140%', '110%', '120%', '130%', '140%', '110%', '120%', '130%', '140%', '110%', '120%', '130%', '140%'});

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
plot([4, 4], [0, 1], 'r--')
plot([8, 8], [0, 1], 'r--')
plot([12, 12], [0, 1], 'r--')
plot([16, 16], [0, 1], 'r--')
text(2.3, 0.8, 'UP')
text(5.5, 0.8, 'DOWN')
text(9.5, 0.8, 'LEFT')
text(13.5, 0.8, 'RIGHT')

%% Evaluate Sequence 2
load Sequence2Homographies

I1 = imread('SEQUENCE2/Image_00a.png');
I1 = single(rgb2gray(I1));

figure(2); hold on; grid on;
title('Accuracy of SIFT in Seq. 2');
xlabel('Zoom'); ylabel('Percentage of correct matches');
xlim([1 size(Sequence2Homographies, 2)]); ylim([0.7 1]);
set(gca, 'xTick', 1:9);
set(gca, 'xTickLabel', {'110%','115%','120%','125%', '130%', '135%', '140%', '145%', '150%'});

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
xlabel('Rotation angle'); ylabel('Percentage of correct matches');
xlim([1 size(Sequence3Homographies, 2)]); ylim([0.7 1]);
set(gca, 'xTick', 1:18);
set(gca, 'xTickLabel', [-45:5:-5, 5:5:45]);

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