
clc
close all
clear;

lambda1=2;
lambda2=1;

load('data_stat_test_submatrix/TPR_FPR_AUC_no_lower_firing_4_4_submatix_4by4.mat')


figure
plot(FPR_value{lambda1,lambda2}, TPR_value{lambda1,lambda2}, '-b', 'LineWidth', 2);
xlabel('False positive rate (FPR)','interpreter','latex')
ylabel('True positive rate (TPR)','interpreter','latex')
title(['AUC = ',num2str(AUC_score(lambda1,lambda2)), ' , ','Frame No. 500 and 501'],'interpreter','latex')
set(gca,'fontsize',14)
set(gca,'TickLabelInterpreter','latex');


