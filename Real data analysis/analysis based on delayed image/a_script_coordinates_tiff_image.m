
clc;
close all;
clear;

image1 = 500;
image2 = 501;

figure; 
img1 = imread(['image_tiff/', num2str(image1), '.tiff']); 
imshow(img1);
title(['Image ', num2str(image1)]);
datacursormode on; 


figure; 
img2 = imread(['image_tiff/', num2str(image2), '.tiff']); 
imshow(img2);
title(['Image ', num2str(image2)]);
datacursormode on; 