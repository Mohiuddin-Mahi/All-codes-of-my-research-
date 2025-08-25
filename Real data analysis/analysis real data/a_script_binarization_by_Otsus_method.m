

clc;
close all;
clear;

% Set parameters
row_num = 1;
col_num = 1;
num_frames = 900;

% Preallocate cell array for performance
lambda_grid_intensity = cell(row_num, col_num);

% Create output directory if it doesn't exist
output_dir = 'grid_intensity_data';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Process each frame
for frame_ind = 1:num_frames
    tic;

    % Construct file name
    filename = sprintf('AIVIA(0226classifier)_dbps-corr_8bit-norm/AIVIA_dbps-corr_0226classifier_%.4d.tif', frame_ind);

    % Read image
    tifimage = imread(filename);

    % Convert to binary using Otsu's method
    threshold = Otsu_method_function(tifimage)/255;
    binary_image = imbinarize(tifimage, threshold);
    lambda_grid_intensity{row_num, col_num} = binary_image;

    % Save data
    ind = frame_ind;  % Make sure 'ind' is defined
    save_filename = fullfile(output_dir, sprintf('grid_intensity_data_%.4d.mat', ind));
    save(save_filename, 'tifimage', 'lambda_grid_intensity', 'threshold');

    toc;
end