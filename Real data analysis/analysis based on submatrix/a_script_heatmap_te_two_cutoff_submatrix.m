
clc
close all
clear;

font=14;
tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
num_frames=500;
resize_param=0.1;
lambda_data1=1:5:56;
lambda_data2=1:5:56;

load(['data_stat_test_submatrix/data_stat_test_no_boundary.mat'])

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



%% 1st order derivative
[gx,gy]=gradient(trans_ent);
magnitude=sqrt(gx.^2+gy.^2);


%% 2nd order derivative according to sulimon's suggestion
[gx2,gy2]=gradient(magnitude);
magnitude2=sqrt(gx2.^2+gy2.^2);

figure
h=heatmap(10*lambda_data1,10*lambda_data2,trans_ent);
h.xlabel('Cutoff distance $\lambda_2$')
h.ylabel('Cutoff distance $\lambda_1$')
h.Title = '$True~TE~(T_{X_{sub}\rightarrow Y_{sub}})$ ; Frame = 500';
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels = CustomXYLabels;
% h.YDisplayLabels = CustomXYLabels;
h.FontSize = font;
colormap('jet(7)')
% set(h,'MissingDataLabel','')
%grid off

% 1st Derivative of TE
figure
h=heatmap(10*lambda_data1, 10*lambda_data2,magnitude);
h.xlabel('Cutoff distance $\lambda_2$')
h.ylabel('Cutoff distance $\lambda_1$')
h.Title='$|\nabla(TE)|$ ; Frame = 500';
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels = CustomXYLabels;
% h.YDisplayLabels = CustomXYLabels;
h.FontSize = font;
colormap('jet(7)')
% set(h,'MissingDataLabel','')
%grid off
%% 2nd Derivative of TE
figure
h=heatmap(10*lambda_data1, 10*lambda_data2,magnitude2);
h.xlabel('Cutoff distance $\lambda_2$')
h.ylabel('Cutoff distance $\lambda_1$')
h.Title='$|\nabla^2(TE)|$ ; Frame = 500';
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels = CustomXYLabels;
% h.YDisplayLabels = CustomXYLabels;
h.FontSize = font;
colormap('jet(7)')
% set(h,'MissingDataLabel','')
%grid off



