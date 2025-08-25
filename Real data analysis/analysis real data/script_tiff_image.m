
clc
close all
clear;
tau=1;
frame_ind=1;

% Read the TIFF image

img = imread('AIVIA(0226classifier)_dbps-corr_8bit-norm/AIVIA_dbps-corr_0226classifier_0001.tif');
figure
imshow(img);
title(['Previous~image~(Frame~',num2str(frame_ind),')'],'interpreter','latex')
set(gca,'fontsize',16)
shg

img1 = imread('AIVIA(0226classifier)_dbps-corr_8bit-norm/AIVIA_dbps-corr_0226classifier_0002.tif');
figure
imshow(img1);
title(['Previous~image~(Frame~',num2str(frame_ind+tau),')'],'interpreter','latex')
set(gca,'fontsize',16)
shg