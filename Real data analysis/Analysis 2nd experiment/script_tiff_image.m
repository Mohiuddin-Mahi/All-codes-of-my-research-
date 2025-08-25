
clc;
close all;
clear;

tau = 1;
frame_ind = 1;

% Construct the filenames properly
filename1 = sprintf('Original_images_CTR_AIVIA/CTR_AIVIA_T%04d.tif', frame_ind);
filename2 = sprintf('Original_images_CTR_AIVIA/CTR_AIVIA_T%04d.tif', frame_ind + tau);

% Read the TIFF images
img = imread(filename1);
figure;
imshow(img);
title(['Current~image~(Frame~', num2str(frame_ind),')'], 'Interpreter', 'latex');
set(gca, 'FontSize', 16);
shg;

img1 = imread(filename2);
figure;
imshow(img1);
title(['Current~image~(Frame~', num2str(frame_ind + tau),')'], 'Interpreter', 'latex');
set(gca, 'FontSize', 16);
shg;