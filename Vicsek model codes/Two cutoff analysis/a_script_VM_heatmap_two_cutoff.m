

clc
close all
clear;

cell1=1;
cell2=2;

noise=6;


r=1;
ncell=2;
font=14;
nsymbols=6;
num_lamda=11;
max_lambda=2;
lambda1=linspace(0,max_lambda,num_lamda);
lambda2=linspace(0,max_lambda,num_lamda);
noise_array=[0.3 0.6 0.9 1.2 1.5 1.8];
load(['data_te/te_cell_',num2str(cell1),'_',num2str(cell2),'_noise_',num2str(noise),'.mat'])

%%% 1st order derivative %%%%

[gx,gy]=gradient(tran_ent);
magnitude1=sqrt(gx.^2+gy.^2);

%%% 2nd order derivative %%%%

[gx1,gy1]=gradient(magnitude1);
magnitude2=sqrt(gx1.^2+gy1.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Transfer entropy %%%%%

figure
h=heatmap(lambda1,lambda2,tran_ent);
h.xlabel('Cutoff distance $(\lambda_2)$')
h.ylabel('Cutoff distance $(\lambda_1)$')
h.Title = {['$T_{X\rightarrow Y}$ ; $\eta=$',num2str(noise_array(noise)),'$\pi$ ; $R=1$']};
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% % h.XDisplayLabels = CustomXYLabels;
% % h.YDisplayLabels = CustomXYLabels;
h.FontSize = font;
colormap('jet')
colorbar off
set(h,'MissingDataLabel','')
%grid off

%%%% 1st order Derivative of TE  %%%%%
figure
h=heatmap(lambda2,lambda1,magnitude1);
h.xlabel('Cutoff distance $(\lambda_2)$')
h.ylabel('Cutoff distance $(\lambda_1)$')
h.Title = {['$|\nabla (T_{X\rightarrow Y})|$ ; $\eta=$',num2str(noise_array(noise)),'$\pi$ ; $R=1$']};
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% % h.XDisplayLabels = CustomXYLabels;
% % h.YDisplayLabels = CustomXYLabels;
h.FontSize = font;
colormap('jet')
colorbar off
set(h,'MissingDataLabel','')


% % %% 2nd Derivative of TE %%%%%
% % figure
% % h=heatmap(lambda2,lambda1,magnitude2);
% % h.xlabel('Cutoff distance $(\lambda_2)$')
% % h.ylabel('Cutoff distance $(\lambda_1)$')
% % h.Title = {['$|\nabla^2 (T_{X\rightarrow Y})|$ ; $\eta=$',num2str(noise_array(noise)),'$\pi$ ; $R=1$']};
% % h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
% % h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
% % h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
% % h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
% % h.NodeChildren(3).Title.Interpreter = 'latex';
% % % % h.XDisplayLabels = CustomXYLabels;
% % % % h.YDisplayLabels = CustomXYLabels;
% % h.FontSize = font;
% % colormap('jet')
% % colorbar off
% % set(h,'MissingDataLabel','')

