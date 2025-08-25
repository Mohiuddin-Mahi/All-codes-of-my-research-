
clc
close all
clear;

lstep=5;

tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;
lambda_data1=1:lstep:71;                             %%lambda_data1=1:10:101;
lambda_data2=1:lstep:71;                             %%lambda_data2=1:10:101;

for frame_ind1=500

    load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind1,'%.3d'),'.mat'])
    data1= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;                  %% x_data
    load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind1+tau,'%.3d'),'.mat'])
    data2= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;                  %% y_data

    im_data=cell(length(lambda_data1),length(lambda_data2));
    trans_ent=zeros(length(lambda_data1),length(lambda_data2));

    for lambda_ind1=1:length(lambda_data1)
        lambda1=lambda_data1(lambda_ind1);
        parfor lambda_ind2=1:length(lambda_data2)
            lambda2=lambda_data2(lambda_ind2);

            if lambda1>lambda2
                tic;
                x= -lambda1:lambda1;
                y= -lambda1:lambda1;

                [X,Y]=meshgrid(x,y);
                X=X(:);
                Y=Y(:);
                I=[];

                I(1,:)=X((X.^2 + Y.^2 )<lambda1^2 & (X.^2 + Y.^2 )>=lambda2^2);
                I(2,:)= Y((X.^2 + Y.^2)<lambda1^2 & (X.^2 + Y.^2 )>=lambda2^2);

                total_count=0;
                counts=zeros(1,8);
                max_x=size(data1,1);
                max_y=size(data1,2);

                for i=1:max_x
                    for j=1:max_y

                        if(data1(i,j)==0 && data2(i,j)==0)
                            im_data{lambda_ind1,lambda_ind2}(i,j)=1;
                        elseif(data1(i,j)==0 && data2(i,j)==1)
                            im_data{lambda_ind1,lambda_ind2}(i,j)=2;
                        elseif(data1(i,j)==1 && data2(i,j)==0)
                            im_data{lambda_ind1,lambda_ind2}(i,j)=3;
                        else
                            im_data{lambda_ind1,lambda_ind2}(i,j)=4;
                        end

                    end
                end

                for ind1=lambda1+1:max_x-(lambda1+1)

                    for ind2=lambda1+1:max_y-(lambda1+1)
                        curr_I=[];
                        curr_I(1,:) = I(1,:) + ind1;
                        curr_I(2,:) = I(2,:) + ind2;
                        if ind1 <= lambda1 || ind2 <= lambda1 || ind1> max_x-lambda1 || ind2>max_y-lambda1

                            curr_nearby_indices = curr_I(:, curr_I(1,:) > 0 & ...
                                curr_I(2,:) > 0 & ...
                                curr_I(1,:) <= max_x & ...
                                curr_I(2,:) <= max_y);
                        else
                            curr_nearby_indices = curr_I;
                        end
                        curr_im_data= im_data{lambda_ind1,lambda_ind2}(sub2ind([max_x max_y],...
                            curr_nearby_indices(1,:),curr_nearby_indices(2,:)));

                        curr_xdata=data1(ind1,ind2);
                        if curr_xdata==0

                            counts(1) = counts(1) + sum(curr_im_data==1); %000

                            counts(2) = counts(2) + sum(curr_im_data==2); %001

                            counts(3) = counts(3) + sum(curr_im_data==3); %010

                            counts(4) = counts(4) + sum(curr_im_data==4); %011
                        else

                            counts(5) = counts(5) + sum(curr_im_data==1); %100

                            counts(6) = counts(6) + sum(curr_im_data==2); %101

                            counts(7) = counts(7) + sum(curr_im_data==3); %110

                            counts(8) = counts(8) + sum(curr_im_data==4); %111
                        end
                        total_count=total_count+length(curr_im_data);
                    end
                end

                pr_y_y_x=counts./total_count;
                if(sum(pr_y_y_x)~=1)
                    'error';
                end
                tr_en1=calc_te_new_code(pr_y_y_x,nsymbols);
                trans_ent(lambda_ind1,lambda_ind2)=tr_en1;
                toc;
            else
                trans_ent(lambda_ind1,lambda_ind2)=NaN;
            end

        end
    end

    save(['data_te_two_cutoff/te_no_bound_lstep_',num2str(lstep),'_frame_',num2str(frame_ind1),'_',num2str(frame_ind1+tau),'.mat'],'trans_ent')
end
