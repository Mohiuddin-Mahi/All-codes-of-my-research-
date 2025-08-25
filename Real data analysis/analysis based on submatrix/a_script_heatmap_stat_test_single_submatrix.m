clc
close all
clear;

font=14;

lambda_data1=1:5:56;
lambda_data2=1:5:56;

load(['data_stat_test_submatrix/data_no_lower_firing_2_1_submatix_4by4.mat'])


%%%% Transfer entropy %%%%%

figure
true_te(pass_or_fail(:,:)==0)=NaN;
h=heatmap(lambda_data1,lambda_data2,true_te);
h.xlabel('Cutoff distance $\lambda_2$')
h.ylabel('Cutoff distance $\lambda_1$')
h.Title = '$T_{X\rightarrow Y}$ ; Frame = 500';
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels = CustomXYLabels;
% h.YDisplayLabels = CustomXYLabels;
h.FontSize = font;
colormap('jet(7)')
% colorbar off
set(h,'MissingDataLabel','')
%grid off

% % figure
% % h=heatmap(lambda1,lambda2,pass_or_fail);
% % h.xlabel('Cutoff distance $\lambda_2$')
% % h.ylabel('Cutoff distance $\lambda_1$')
% % h.Title = '$T_{X\rightarrow Y}$ ; $\eta_0=0.1\pi$';
% % h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
% % h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
% % h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
% % h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
% % h.NodeChildren(3).Title.Interpreter = 'latex';
% % % h.XDisplayLabels = CustomXYLabels;
% % % h.YDisplayLabels = CustomXYLabels;
% % h.FontSize = font;
% % colormap('jet')
% % set(h,'MissingDataLabel','')
% %grid off
