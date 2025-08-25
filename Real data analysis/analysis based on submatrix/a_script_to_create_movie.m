
clc
close all
clear;

num_frame=1190;

v=VideoWriter('movie_1.avi');
v.FrameRate=8;
v.Quality=10;
open(v)

for ind=1:num_frame
    tic;
    figure
    load(['large_image_binarized_data_',num2str(ind,'%03d'),'.mat']);
    imshow(curr_imData,[0 1])
    title(['Frame Number: ',num2str(ind)])
    shg
    g=getframe(gcf);
    writeVideo(v,g);
    close all;
    toc
end
close(v)