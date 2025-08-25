
clc
close all
clear;

lambda_data1=1:5:56;
lambda_data2=1:5:56;

load('data_stat_test_submatrix/data_delet_2000_firing_grids_all_submatix_3by3.mat')

TPR_value=cell(length(lambda_data1),length(lambda_data2));
FPR_value=cell(length(lambda_data1),length(lambda_data2));
AUC_score=zeros(length(lambda_data1),length(lambda_data2));

for lambda_ind1=1:length(lambda_data1)
    lambda1=lambda_data1(lambda_ind1);
    for lambda_ind2=1:length(lambda_data2)
        lambda2=lambda_data2(lambda_ind2);

        if lambda1>lambda2
            [TPR,FPR,AUC] = roc_curve_function_mohi(surrogate_te{lambda_ind1,lambda_ind2}', true_te{lambda_ind1,lambda_ind2}');
            TPR_value{lambda_ind1,lambda_ind2}=TPR;
            FPR_value{lambda_ind1,lambda_ind2}=FPR;
            AUC_score(lambda_ind1,lambda_ind2)=AUC;

        else
            TPR_value{lambda_ind1,lambda_ind2}=NaN;
            FPR_value{lambda_ind1,lambda_ind2}=NaN;
            AUC_score(lambda_ind1,lambda_ind2)=NaN;
        end

    end
end
% save('data_stat_test_submatrix/TPR_FPR_AUC_no_lower_firing_all_submatix_4by4.mat','TPR_value','FPR_value','AUC_score')

%%%%%%% Heatmap AUC %%%%%%%%%%%%%%%%
figure
h=heatmap(lambda_data1,lambda_data2,AUC_score);
h.xlabel('Cutoff distance $\lambda_2$')
h.ylabel('Cutoff distance $\lambda_1$')
h.Title = 'AUC ; Frame No. 500 and 501';
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels = CustomXYLabels;
% h.YDisplayLabels = CustomXYLabels;
h.FontSize = 14;
colormap('jet(7)')
% colorbar off
set(h,'MissingDataLabel','')
%grid off



