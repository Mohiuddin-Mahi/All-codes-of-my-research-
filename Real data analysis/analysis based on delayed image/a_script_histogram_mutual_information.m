
clc
close all
clear;

font=16;
tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;
load(['data_mutual_inf/mi_data_frame_500_501_frames_980_1190.mat'])

figure
histogram(mutual_inf(2:end),20,'normalization','probability')
hold on
h(1)=plot([mutual_inf(1) mutual_inf(1)],[0 0.5],'-r','linewidth',2);

xlabel('mutual inf.','interpreter','latex')
ylabel('Probaility','interpreter','latex')
set(gca,FontSize=font);


