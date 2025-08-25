
clc
close all
clear;

lstep=5;
frame_ind=501;

font=16;
tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;

lambda_data1=1:lstep:71;              %%lambda_data1=1:3:70; 1:5:101; 1:10:101;
lambda_data2=1:lstep:71;              %%lambda_data2=1:3:70; 1:5:101; 1:10:101;

load(['data_te_two_cutoff/te_no_bound_lstep_',num2str(lstep),'_frame_',num2str(frame_ind),...
    '_',num2str(frame_ind+tau),'.mat'])

%% 1st order derivative
[gx,gy]=gradient(trans_ent);
magnitude=sqrt(gx.^2+gy.^2);


%% 2nd order derivative according to sulimon's suggestion
[gx2,gy2]=gradient(magnitude);
magnitude2=sqrt(gx2.^2+gy2.^2);

figure
h=heatmap(10*lambda_data1,10*lambda_data2,trans_ent);
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
% colorbar off
set(h,'MissingDataLabel','')
%grid off


% 1st Derivative of TE
figure
h=heatmap(10*lambda_data1, 10*lambda_data2,magnitude);
h.xlabel('Cutoff distance $(\lambda_2)$')
h.ylabel('Cutoff distance $(\lambda_1)$')
h.Title = ['$|\nabla(T_{' num2str(frame_ind) '\rightarrow' num2str(frame_ind+tau) '})|$'];
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
h.FontSize = font;
colormap('jet')
% colorbar off
set(h,'MissingDataLabel','')
%grid off

% % %% 2nd Derivative of TE
% % figure
% % h=heatmap(10*lambda_data1, 10*lambda_data2,magnitude2);
% % h.xlabel('Cutoff distance $(\lambda_2)$')
% % h.ylabel('Cutoff distance $(\lambda_1)$')
% % h.Title = ['$|\nabla^2(T_{' num2str(frame_ind) '\rightarrow' num2str(frame_ind+tau) '})|$'];
% % h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
% % h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
% % h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
% % h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
% % h.NodeChildren(3).Title.Interpreter = 'latex';
% % h.FontSize = font;
% % colormap('jet')
% % % colorbar off
% % set(h,'MissingDataLabel','')
% % %grid off





