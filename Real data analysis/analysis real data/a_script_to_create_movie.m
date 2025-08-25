
clc
close all
clear;

num_frame=720;

v=VideoWriter('movie_current_data_binary_all_image_by_74.avi');
v.FrameRate=10;
v.Quality=10;
open(v)

for ind=1:num_frame
    tic;
    figure
    load(['grid_intensity_data_2nd_experiment_binary_74/grid_intensity_data_',num2str(ind,'%.4d'),'.mat']);
    imshow(lambda_grid_intensity{1,1},[0 1])
    title(['Frame Number: ',num2str(ind)])
    shg
    g=getframe(gcf);
    writeVideo(v,g);
    close all;
    toc
end
close(v)