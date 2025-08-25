

clc
close all
clear;

lambda1=8;
lambda2=6;
font=14;

load(['data_stat_test_submatrix/data_delet_2000_firing_grids_all_submatix_4by4.mat'])

mdi= surrogate_te{lambda1,lambda2};     % surro data set %
cb=0.95;              % confidence level%
ce=cumsum(1/numel(mdi)*ones(1,numel(mdi)));
smd=sort(mdi,'ascend');
d_cut=smd(find(ce<=cb,1,'last'));

figure
histogram(mdi,20,'normalization','probability')
hold on
h(1)=plot([d_cut d_cut],[0 0.5],'-r','linewidth',2);
hold on
h(2)=plot([mean(true_te{lambda1,lambda2}) mean(true_te{lambda1,lambda2})],[0 0.5],'-b','linewidth',2);
hold on
histogram(true_te{lambda1,lambda2},20,'normalization','probability')
xlabel('Surrogate $T_{X\rightarrow Y}$','interpreter','latex')
ylabel('Probaility','interpreter','latex')
title('Statistical test','interpreter','latex')
legend(h,'$95\%$ Confidence cutoff','$T_{X\rightarrow Y}$','location','northwest','interpreter','latex')
set(gca,FontSize=font);


