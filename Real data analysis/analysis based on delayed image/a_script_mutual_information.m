

clc
close all
clear;

tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;

frame1=500;
frame2_num=[frame1+tau,980:1190];
mutual_inf=zeros(1,length(frame2_num));

for frame_ind=1:length(frame2_num)
    frame2=frame2_num(frame_ind);
    tic;
    load(['grid_intensity_data/grid_intensity_data_',num2str(frame1,'%.3d'),'.mat'])
    data1= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;            %% x_data
    load(['grid_intensity_data/grid_intensity_data_',num2str(frame2,'%.3d'),'.mat'])
    data2= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;            %% y_data

    pr_x_y=zeros(1,4);
    max_x=size(data1,1);
    max_y=size(data1,2);
    im_data=zeros(max_x,max_y);

    for i=1:max_x
        for j=1:max_y

            if(data1(i,j)==0 && data2(i,j)==0)
                im_data(i,j)=1;    %%% 00
            elseif(data1(i,j)==0 && data2(i,j)==1)
                im_data(i,j)=2;    %%% 01
            elseif(data1(i,j)==1 && data2(i,j)==0)
                im_data(i,j)=3;    %%% 10
            else
                im_data(i,j)=4;    %%% 11
            end

        end
    end

    for pr_ind=1:4
        pr_x_y(pr_ind)=length(find(im_data==pr_ind))/numel(im_data);
    end
    if(sum(pr_x_y)~=1)
        'error';
    end
    mutual_inf(frame_ind)=calc_mutual_information(pr_x_y,nsymbols);
    toc
end
save(['data_mutual_inf/mi_data_frame_',num2str(frame1),'_',num2str(frame1+tau),'_frames_980_1190'...
        '.mat'],'mutual_inf')
