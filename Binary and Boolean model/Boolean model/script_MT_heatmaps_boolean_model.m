

clc
close all
clear;

font=18;
nbird=3;
num_coup=11;
num_theta=11;
theta_array=linspace(0,0.25,num_theta);
coup_array=linspace(0,1,num_coup);

%%%%%%%%%%%%%%%% heatmap %%%%%%%%%%%%%%%%%

figure
load(['data_te/data_monot_test_cycle_sort_birds_1_2.mat'],'mon_te','mon_te_new')
h=heatmap(coup_array,theta_array,mon_te_new,'CellLabelColor', 'None');
h.XLabel = '$\gamma$';
h.YLabel = ('$\Theta$');
h.Title = {'$MT_{X\rightarrow Y}$'};
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels={'0','','0.4','','0.8','','1.2','','1.6','','2'};
% h.YDisplayLabels={'0.39','','1.57','','2.75','','3.93',...
%     '','5.11','','6.28'};
% colormap('jet(4)')
custom_cmap = [
    0.0, 1.0, 0.0   % Green
    1.0, 1.0, 0.0;  % Yellow
    1.0, 0.5, 0.0;  % Orange
    1.0, 0.0, 0.0;  % Red
];
colormap(gca, custom_cmap);
colorbar('off')
caxis([0, 1]);
set(gca,FontSize=font);
set(h,'MissingDataLabel','')
%%% grid off

figure
load(['data_te/data_monot_test_cycle_sort_birds_2_3.mat'],'mon_te','mon_te_new')
h=heatmap(coup_array,theta_array,mon_te_new,'CellLabelColor', 'None');
h.XLabel = '$\gamma$';
h.YLabel = ('$\Theta$');
h.Title = {'$MT_{Y\rightarrow Z}$'};
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels={'0','','0.4','','0.8','','1.2','','1.6','','2'};
% h.YDisplayLabels={'0.39','','1.57','','2.75','','3.93',...
%     '','5.11','','6.28'};
% colormap('jet(4)')
custom_cmap = [
    0.0, 1.0, 0.0   % Green
    1.0, 1.0, 0.0;  % Yellow
    1.0, 0.5, 0.0;  % Orange
    1.0, 0.0, 0.0;  % Red
];
colormap(gca, custom_cmap);
colorbar('off')
caxis([0, 1]);
set(gca,FontSize=font);
set(h,'MissingDataLabel','')
%%%% grid off

figure
load(['data_te/data_monot_test_cycle_sort_birds_1_3.mat'],'mon_te','mon_te_new')
h=heatmap(coup_array,theta_array,mon_te_new,'CellLabelColor', 'None');
h.XLabel = '$\gamma$';
h.YLabel = ('$\Theta$');
h.Title = {'$MT_{X\rightarrow Z}$'};
h.NodeChildren(3).XAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).XAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).YAxis.Label.Interpreter = 'latex';
h.NodeChildren(3).YAxis.TickLabelInterpreter = 'latex';
h.NodeChildren(3).Title.Interpreter = 'latex';
% h.XDisplayLabels={'0','','0.4','','0.8','','1.2','','1.6','','2'};
% h.YDisplayLabels={'0.39','','1.57','','2.75','','3.93',...
%     '','5.11','','6.28'};
% colormap('jet(4)')
custom_cmap = [
    0.0, 1.0, 0.0   % Green
    1.0, 1.0, 0.0;  % Yellow
    1.0, 0.5, 0.0;  % Orange
    1.0, 0.0, 0.0;  % Red
];
colormap(gca, custom_cmap);
hs = struct(h);
hs.Colorbar.Ticks = [0.125, 0.375, 0.625, 0.875];
hs.Colorbar.TickLabels = {'0', '0.25', '0.5', '1'};
set(hs.Colorbar,'TickLabelInterpreter','latex')
hs.Colorbar.Title.String = 'D';
hs.Colorbar.Title.Interpreter = 'latex';
caxis([0, 1]);
set(gca,FontSize=font);
set(h,'MissingDataLabel','')
%%%% grid off
