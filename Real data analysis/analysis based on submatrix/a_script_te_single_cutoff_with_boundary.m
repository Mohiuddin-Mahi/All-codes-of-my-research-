
clc
close all
clear;

tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
num_frames=500;
resize_param=0.1;
lambda_data=1:5:56;                    %%% lambda_data=1:3:70;

% for frame_ind=500
% 
%     load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind,'%.3d'),'.mat'])
%     data1= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;
%     load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind+tau,'%.3d'),'.mat'])
%     data2= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;
% 
%     im_data=cell(1,length(lambda_data));
%     trans_ent=zeros(1,length(lambda_data));
% 
%     parfor lambda_ind=1:length(lambda_data)
%         tic;
%         lambda=lambda_data(lambda_ind);
%         x= -lambda:lambda;
%         y= -lambda:lambda;
%         [X,Y]=meshgrid(x,y);
%         X=X(:);
%         Y=Y(:);
% 
%         I=[];
%         I(1,:)=X((X.^2 + Y.^2 )<lambda^2 & (X.^2 + Y.^2 )~=0);
%         I(2,:)= Y ((X.^2 + Y.^2)<lambda^2 & (X.^2 + Y.^2 )~=0);
% 
%         total_count=0;
%         counts=zeros(1,8);                       %%% (000, 001, 010, 011, 100, 101, 110, 111)
%         max_x=size(data1,1);
%         max_y=size(data1,2);
% 
%         for i=1:max_x
%             for j=1:max_y
% 
%                 if(data1(i,j)==0 && data2(i,j)==0)
%                     im_data{lambda_ind}(i,j)=1;            %%% 00                      x_t & x_t+tau
%                 elseif(data1(i,j)==0 && data2(i,j)==1)
%                     im_data{lambda_ind}(i,j)=2;            %%% 01
%                 elseif(data1(i,j)==1 && data2(i,j)==0)
%                     im_data{lambda_ind}(i,j)=3;            %%% 10
%                 else
%                     im_data{lambda_ind}(i,j)=4;            %%% 11
%                 end
% 
%             end
%         end
% 
%         for ind1=1:max_x
%             for ind2=1:max_y
% 
%                 curr_I=[];
%                 curr_I(1,:) = I(1,:) + ind1;
%                 curr_I(2,:) = I(2,:) + ind2;
% 
%                 if ind1 < lambda || ind2 < lambda || ind1> max_x-lambda || ind2>max_y-lambda
%                     curr_nearby_indices = curr_I(:, curr_I(1,:) > 0 & curr_I(2,:) > 0 & curr_I(1,:) <= max_x & curr_I(2,:) <= max_y);
%                 else
%                     curr_nearby_indices = curr_I;
%                 end
% 
%                 curr_im_data= im_data{lambda_ind}(sub2ind([max_x max_y],curr_nearby_indices(1,:),curr_nearby_indices(2,:)));
% 
%                 curr_ydata=data1(ind1,ind2);
%                 if curr_ydata==0
% 
%                     counts(1) = counts(1) + sum(curr_im_data==1); %000                    x_t,y_t,y_t+tau
% 
%                     counts(2) = counts(2) + sum(curr_im_data==2); %001
% 
%                     counts(3) = counts(3) + sum(curr_im_data==3); %010
% 
%                     counts(4) = counts(4) + sum(curr_im_data==4); %011
%                 else
% 
%                     counts(5) = counts(5) + sum(curr_im_data==1); %100
% 
%                     counts(6) = counts(6) + sum(curr_im_data==2); %101
% 
%                     counts(7) = counts(7) + sum(curr_im_data==3); %110
% 
%                     counts(8) = counts(8) + sum(curr_im_data==4); %111
%                 end
%                 total_count=total_count+length(curr_im_data);
% 
%             end
%         end
%         pr_x_x_y=counts./total_count;
%         tr_en1=calc_te_new_code(pr_x_x_y,nsymbols);
%         trans_ent(lambda_ind)=tr_en1;
%         toc
%     end
% end
% 
% save(['data_te_single_cutoff/te_with_boundary_frame_',num2str(frame_ind),'.mat'],'trans_ent')

%%%%%%%%%%%%%%% Figure %%%%%%%%%%%%%%%%%%

load('data_te_single_cutoff/te_with_boundary_frame_500.mat')

derivative1_TE=diff(trans_ent)./diff(lambda_data);
derivative2_TE=diff(derivative1_TE)./diff(lambda_data(1:length(lambda_data)-1));

%%% Transfer Entropy %%
figure
h(1)=plot(10*lambda_data,trans_ent,'LineWidth',1.5);
xlim([1 10*max(lambda_data)])
xlabel('Cutoff distance ($\lambda$)','interpreter','latex')
ylabel('TE','interpreter','latex')
title(['Frame $500$'],'interpreter','latex')
legend('$\tau=1$','location','best','interpreter','latex')
set(gca,'fontsize',14)
set(gca,'TickLabelInterpreter','latex');

%%% 1st derivative of Transfer Entropy%%
figure
h(2)=plot(10*lambda_data(2:end),derivative1_TE,'LineWidth',1.5);
xlim([1 10*max(lambda_data)])
xlabel('Cutoff distance ($\lambda$)','interpreter','latex')
ylabel('$dTE/d\lambda$','interpreter','latex')
title(['Frame $500$'],'interpreter','latex')
legend('$\tau=1$','location','best','interpreter','latex')
set(gca,'fontsize',14)
set(gca,'TickLabelInterpreter','latex');

%%% 2nd derivative of Transfer Entropy%%
figure
h(3)=plot(10*lambda_data(3:end),derivative2_TE,'LineWidth',1.5);
xlim([1 10*max(lambda_data)])
xlabel('Cutoff distance ($\lambda$)','interpreter','latex')
ylabel('$d^2TE/d\lambda^2$','interpreter','latex')
title(['Frame $500$'],'interpreter','latex')
legend('$\tau=1$','location','best','interpreter','latex')
set(gca,'fontsize',14)
set(gca,'TickLabelInterpreter','latex');

