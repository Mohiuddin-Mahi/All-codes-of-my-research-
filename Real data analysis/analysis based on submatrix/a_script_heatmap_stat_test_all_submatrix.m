

clc
close all
clear;

font=14;

lambda_data1=1:5:56;
lambda_data2=1:5:56;

load(['data_stat_test_submatrix/data_stat_test_all_submatix_6by6.mat'])

for lambda_ind1=1:length(lambda_data1)
        lambda1=lambda_data1(lambda_ind1);
        for lambda_ind2=1:length(lambda_data2)
            lambda2=lambda_data2(lambda_ind2);
            if lambda1>lambda2
               trans_ent(lambda_ind1,lambda_ind2)=mean(true_te{lambda_ind1,lambda_ind2});
            else
                trans_ent(lambda_ind1,lambda_ind2)=NaN;
            end
        end
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Transfer entropy %%%%%

figure
trans_ent(pass_or_fail(:,:)==0)=NaN;
h=heatmap(lambda_data1,lambda_data2,trans_ent);
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
