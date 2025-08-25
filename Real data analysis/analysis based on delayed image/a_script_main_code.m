

% %%%% Compute grid intensity %%%%%%
% 
% clc
% close all
% clear;
% 
% row_num=1;
% col_num=1;
% fig_indx=0;                  %%%%% 1 to see figure %%%%%%
% num_frames=1190;
% max_lambda=2000;
% for ind=0:num_frames
%     tic
%     lambda_grid_intensity=lambda_grid_intensity_function_new(ind,max_lambda,row_num,col_num,fig_indx);
%     save(['grid_intensity_data/grid_intensity_data_',num2str(ind),'.mat'],'lambda_grid_intensity')
%     toc
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %% Compute firing data with location %%%%%%%
% 
% clc
% close all
% clear;
% 
% tau=1;
% row_num=1;
% col_num=1;
% num_frame=1190;
% resize_param=0.1;
% 
% im_data_all=cell(1,num_frame-1);
% firing_data_with_location=cell(1,num_frame-1);
% for frame_ind=1:num_frame-tau
%     load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind),'.mat'])
%     t_data=lambda_grid_intensity;
%     load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind+tau),'.mat'])
%     t1_data=lambda_grid_intensity;
%     tic;
%     for row_ind=1:row_num
%         for col_ind=1:col_num
%             data= t_data{row_ind,col_ind};                     %%%% time t
%             data1= t1_data{row_ind,col_ind};                   %%%% time t+tau
%             [im,fir]=location_of_firing_function(resize_param,data,data1);
%             im_data_all{frame_ind}{row_ind,col_ind}=im;
%             firing_data_with_location{frame_ind}{row_ind,col_ind}=fir;
%         end
%     end
%     toc
% end
% save('im_data_and_firing_location/im_data_and_firing_location.mat','im_data_all','firing_data_with_location','-v7.3');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Save Im Data & Firing data seperately %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all
clear;

tau=1;
col_num=1;
row_num=1;
num_frames=1190;
load(['im_data_and_firing_location/im_data_and_firing_location.mat'])

data0=[];                %%% firing data of previous frame i.e., frame_ind-tau %%%%%
data1=[];                %%% firing data of frame_ind %%%%%                      
data2=[];                %%% im_data of frame_ind %%%
data3=[];                %%% im_data of previous frame %%%%

for frame_ind=1:num_frames-tau
    tic
    for row_ind=1:row_num
        for col_ind=1:col_num
            if frame_ind>tau && ~isempty(im_data_all{frame_ind-tau})
                data3{row_ind,col_ind}=im_data_all{frame_ind-tau}{row_ind,col_ind};
            end
            if frame_ind<length(firing_data_with_location)
                data2{row_ind,col_ind}=im_data_all{frame_ind}{row_ind,col_ind};
            end
            if frame_ind>tau && ~isempty(firing_data_with_location{frame_ind-tau})
                data0{row_ind,col_ind}=firing_data_with_location{frame_ind-tau}{row_ind,col_ind};
            end
            data1{row_ind,col_ind}= firing_data_with_location{frame_ind}{row_ind,col_ind};
        end
    end
    save(strcat('im_data/im_data_',num2str(frame_ind),'.mat'),'data0','data1','data2','data3');
    toc;
end


% %%%%%%%%%% Compute total counts for single frame %%%%%%%%%%%%%
% clc
% close all
% clear;
% 
% tau=1;
% row_num=1;
% col_num=1;
% num_frame=510;
% resize_param=0.1;
% lambda_data=1:3:100;
% 
% for frame_ind=495:num_frame-tau
%     load(['grid_intensity_data_',num2str(frame_ind),'.mat'])
%     for row_ind=1:row_num
%         for col_ind=1:col_num
%             data1{row_ind,col_ind}= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;
%         end
%     end
%     load(['grid_intensity_data_',num2str(frame_ind+tau),'.mat'])
%     for row_ind=1:row_num
%         for col_ind=1:col_num
%             data2{row_ind,col_ind}= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;
%         end
%     end
%     for row_ind=1:row_num
%         for col_ind=1:col_num
%             [total_counts{row_ind,col_ind}]=total_counts_function(data1{row_ind,col_ind},data2{row_ind,col_ind},lambda_data);
%         end
%     end
% end
% save('total_counts_data.mat','total_counts','lambda_data')
% 
% 
% % %%%%%% Compute transfer entropy combining some frames %%%%%%%
% clc
% close all
% clear;
% 
% tau=1;
% row_num=1;
% col_num=1;
% nsymbols=2;
% num_frame=455;
% com_frame_num=3;
% lambda_data=1:1:6;
% 
% tic;
% load('total_counts_data.mat')
% 
% counts=zeros(length(lambda_data),6,8);
% for lambda_ind=1:length(lambda_data)
%     tic
%     lambda=lambda_data(lambda_ind);
%     x= -lambda:lambda;
%     y = -lambda:lambda;
%     [X,Y]=meshgrid(x,y);
%     X=X(:);
%     Y=Y(:);
%     I=[];
% 
%     I(1,:)=X((X.^2 + Y.^2 )<= lambda^2 & (X.^2 + Y.^2 )~=0);
%     I(2,:)= Y ((X.^2 + Y.^2)<=lambda^2 & (X.^2 + Y.^2 )~=0);
% 
%     for row_ind=1:row_num
%         for col_ind=1:col_num
%             [te]=te_calc_function_with_combining(num_frame,I,row_ind,col_ind,lambda,lambda_ind,total_counts{row_ind,col_ind},nsymbols,com_frame_num,tau);
%             TE{row_ind,col_ind}{lambda_ind}=te;
%         end
%     end
% 
%     toc
%     save(['tau_1_with_combinig_TE_results_frame',num2str(num_frame),'.mat'],'TE','lambda_data')
% end
% 
% 
% for row_ind=1
%     for col_ind=1
%         for frame_ind=900
%             for lambda_ind=1:length(lambda_data)
%                 data=TE{row_ind,col_ind}{lambda_ind};
%                 TE_data{row_ind,col_ind}(frame_ind,lambda_ind)=data(frame_ind,lambda_ind);
%             end
%         end
%     end
% end
% 
% figure;
% plot(lambda_data(2:end),diff(TE_data{1,2}(900,:))./diff(lambda_data))
% title('Using new code')
% 
