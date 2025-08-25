

clc;
close all;
clear;

num_frames = 900;
threshold_values=zeros(1,num_frames);

for frame_ind = 1:num_frames
    tic;
    load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind,'%.4d'),'.mat'],'threshold')
    threshold_values(frame_ind)=threshold*255;
    toc;
end

% --- Plot Threshold vs Frame Number ---
figure;
plot(1:num_frames, threshold_values, '-', 'LineWidth', 2);
xlabel('Frame Number');
ylabel('Threshold');
title('Threshold vs Frame Number');
xlim([1 900])
%grid on;
set(gca, 'FontSize', 14);