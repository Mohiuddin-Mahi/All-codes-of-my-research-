
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

load(['data_te_two_cutoff/te_no_boundary_frame_500.mat'])



%% 1st order derivative
[gx,gy]=gradient(trans_ent);
magnitude=sqrt(gx.^2+gy.^2);


%% 2nd order derivative according to sulimon's suggestion
[gx2,gy2]=gradient(magnitude);
magnitude2=sqrt(gx2.^2+gy2.^2);

figure
h(1)=heatmap(10*lambda_data1,10*lambda_data2,trans_ent);
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
title(['TE , Frame=',num2str(num_frames)])
colorbar
colormap(jet(7))
% grid off
set(gca,FontSize=font);

% 1st Derivative of TE
figure
h(2)=heatmap(10*lambda_data1, 10*lambda_data2,magnitude);
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
title(['|\nabla(TE)|',' , Frame=',num2str(num_frames)])
colorbar
colormap(jet(7))
% grid off
set(gca,FontSize=font);

%% 2nd Derivative of TE
figure
h(4)=heatmap(10*lambda_data1, 10*lambda_data2,magnitude2);
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
title(['|\nabla^2(TE)|',' , Frame=',num2str(num_frames)])
colorbar
colormap(jet(7))
% grid off
set(gca,FontSize=font);








% % %% 2nd order derivative according to my understanding
% % [gx1,gy1]=gradient(gradient(trans_ent));
% % magnitude1=sqrt(gx1.^2+gy1.^2);
% % %% 2nd Derivative of TE
% % figure
% % h(3)=heatmap(10*lambda_data1, 10*lambda_data2,magnitude1);
% % xlabel('Cutoff distance \lambda_2')
% % ylabel('Cutoff distance \lambda_1')
% % title(['|\nabla^2(TE)|','Frame=',num2str(num_frames)])
% % colorbar
% % colormap(jet(7))
% % % grid off
% % set(gca,FontSize=font);

