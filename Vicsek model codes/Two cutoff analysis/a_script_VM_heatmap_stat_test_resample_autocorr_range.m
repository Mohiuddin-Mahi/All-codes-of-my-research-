

clc
close all
clear;

cell1=1;
cell2=2;

noise=3;

font=14;

num_lamda=11;
max_lambda=2;
lambda1=linspace(0,max_lambda,num_lamda);
lambda2=linspace(0,max_lambda,num_lamda);
noise_array=[0.3 0.6 0.9 1.2 1.5 1.8];

load(['data_te_resample_autocorr_range/0.1stat_test_cell_',num2str(cell1),'_',num2str(cell2),'_noise_',num2str(noise),'.mat'])

%%%% Transfer entropy %%%%%

figure
true_te(pass_or_fail(:,:)==0)=NaN;
h=heatmap(lambda1,lambda2,true_te);
h.xlabel('Cutoff distance $\lambda_2$')
h.ylabel('Cutoff distance $\lambda_1$')
h.Title = {['$T_{X\rightarrow Y}$ ; $\eta=$',num2str(noise_array(noise)),'$\pi$ ; $R=1$']};
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% % h.XDisplayLabels = CustomXYLabels;
% % h.YDisplayLabels = CustomXYLabels;
h.FontSize = font;
colormap('jet(7)')
% colorbar off
set(h,'MissingDataLabel','')
% %grid off

