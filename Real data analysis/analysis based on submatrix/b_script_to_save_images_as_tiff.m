
%%% Script to save image data files as tiff %%%

clc
close all
clear;

num_frame=1190;
for ind=1007:num_frame
    tic;
    figure
    load(['large_image_binarized_data_',num2str(ind,'%03d'),'.mat']);
    imshow(curr_imData,[0 1])
    title(['Frame Number: ',num2str(ind)])
    shg
    imwrite(logical(curr_imData),strcat(num2str(ind),'.tiff'),'Compression','none');
    toc
end
