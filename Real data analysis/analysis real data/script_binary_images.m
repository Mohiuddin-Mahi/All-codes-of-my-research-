

clc
close all
clear;

tau=1;
row_ind=1;
col_ind=1;
frame_ind=1;
resize_param=1;   %%% For original image change0.1 to 1

load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind,'%.4d'),'.mat'])
data_x= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;

figure
imshow(data_x,[0 1])
title(['Previous~data~(Frame~',num2str(frame_ind),')'],'interpreter','latex')
% title(['New~binary~image~(Frame~',num2str(frame_ind),')'],'interpreter','latex')
set(gca,'fontsize',14)
shg

% load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind+tau,'%.4d'),'.mat'])
% data_y= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;
% figure
% imshow(data_y,[0 1])
% title(['Binary~image~(Frame~',num2str(frame_ind+tau),')'],'interpreter','latex')
% % title(['New~binary~image~(Frame~',num2str(frame_ind+tau),')'],'interpreter','latex')
% set(gca,'fontsize',16)
% shg