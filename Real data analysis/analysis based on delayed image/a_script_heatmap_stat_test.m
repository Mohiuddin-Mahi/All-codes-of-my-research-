

clc
close all
clear;

lstep=5;
frame_ind=500;

tau=1;
font=16;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;

lambda_data1=1:lstep:71;
lambda_data2=1:lstep:71;

load(['data_stat_test/stat_test_lstep_',num2str(lstep),'_frame_',num2str(frame_ind),...
    '_',num2str(frame_ind+tau),'_surframe_550_790.mat'])

te_value=[];
for lambda_ind1=1:length(lambda_data1)
        lambda1=lambda_data1(lambda_ind1);
        for lambda_ind2=1:length(lambda_data2)
            lambda2=lambda_data2(lambda_ind2);
            if lambda1>lambda2
               te_value=[te_value,true_te(lambda_ind1,lambda_ind2)];
            end
        end
 end


%%%% Heatmap without stat test %%%%%

figure
h=heatmap(10*lambda_data1,10*lambda_data2,true_te);
h.xlabel('Cutoff distance $(\lambda_2)$')
h.ylabel('Cutoff distance $(\lambda_1)$')
h.Title = ['$T_{' num2str(frame_ind) '\rightarrow' num2str(frame_ind+tau) '}$'];
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
h.FontSize = font;
colormap('jet')
caxis([min(te_value) max(te_value)])
% colormap('jet(7)')
% colorbar off
set(h,'MissingDataLabel','')
%grid off


%%%% Heatmap with stat test %%%%%

figure
true_te(pass_or_fail(:,:)==0)=NaN;
h=heatmap(10*lambda_data1,10*lambda_data2,true_te);
h.xlabel('Cutoff distance $(\lambda_2)$')
h.ylabel('Cutoff distance $(\lambda_1)$')
h.Title = ['$T_{' num2str(frame_ind) '\rightarrow' num2str(frame_ind+tau) '}$'];
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
h.FontSize = font;
colormap('jet')
caxis([min(te_value) max(te_value)])
% colormap('jet(7)')
% colorbar off
set(h,'MissingDataLabel','')
%grid off

