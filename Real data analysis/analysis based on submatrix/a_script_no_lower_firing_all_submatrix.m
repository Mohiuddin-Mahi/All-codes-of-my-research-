
clc
close all
clear;

tau=1;
row_ind=1;
col_ind=1;
alpha=0.05;
nsymbols=2;
min_firing=200;
num_frames=500;
resize_param=0.1;
l1_array=1:5:56;
l2_array=1:5:56;


for frame_ind=500

    %%% For resize_param=0.1 %%%%

    load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind,'%.3d'),'.mat'])
    data_y= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;
    %cell_y=mat2cell(data_y,[153 153 153 153 153 153],[221 221 221 221 221 221]);           %% for 6by6 grids
    cell_y=mat2cell(data_y(1:end-2,1:end-2),[229 229 229 229],[331 331 331 331]);          %% for 4by4 grids
    %cell_y=mat2cell(data_y,[306 306 306],[442 442 442]);                                    %% for 3by3 grids

    load(['grid_intensity_data/grid_intensity_data_',num2str(frame_ind+tau,'%.3d'),'.mat'])
    data_x= imresize(double(lambda_grid_intensity{row_ind,col_ind}),resize_param)>0;
    %cell_x=mat2cell(data_x,[153 153 153 153 153 153],[221 221 221 221 221 221]);
    cell_x=mat2cell(data_x(1:end-2,1:end-2),[229 229 229 229],[331 331 331 331]);
    %cell_x=mat2cell(data_x,[306 306 306],[442 442 442]);

    %%%%%%%%%%%%%%%%%%%%%%%%

    [firing_y,firing_x]=firing_cell_counting(cell_y,cell_x);

    all_pr=zeros(length(l1_array),length(l2_array));
    true_te=cell(length(l1_array),length(l2_array));
    pass_or_fail=zeros(length(l1_array),length(l2_array));
    true_prob=cell(length(l1_array),length(l2_array));
    surrogate_prob=cell(length(l1_array),length(l2_array));
    surrogate_te=cell(length(l1_array),length(l2_array));

    for lambda_ind1=1:length(l1_array)
        lambda1=l1_array(lambda_ind1);
        parfor lambda_ind2=1:length(l2_array)
            lambda2=l2_array(lambda_ind2);
            if lambda1>lambda2

                tic;
                x= -lambda1:lambda1;
                y= -lambda1:lambda1;

                [X,Y]=meshgrid(x,y);
                X=X(:);
                Y=Y(:);
                I=[];

                I(1,:)= X((X.^2 + Y.^2)<=lambda1^2 & (X.^2 + Y.^2 )>lambda2^2);
                I(2,:)= Y((X.^2 + Y.^2)<=lambda1^2 & (X.^2 + Y.^2 )>lambda2^2);

                ind_tr=1;
                ind_sr=1;
                tr_te=[];sur_te=[];
                tr_pr={};sur_pr={};

                for indy=1:size(cell_y,1)
                    for indx=1:size(cell_y,2)
                        if (firing_y(indy,indx)>=min_firing && firing_x(indy,indx)>=min_firing)
                            [event_y,event_x]=adjacent_and_min_firing_grids_delete_function_new(cell_y,cell_x,indy,indx,min_firing);
                            data1=event_y;            %% Y data
                            data2=event_x;            %% X data

                            for trail1=1:length(data2)

                                total_count=0;
                                counts=zeros(1,8);
                                max_x=size(data1{1},1);
                                max_y=size(data1{1},2);
                                im_data=zeros(max_x,max_y);

                                for i=1:max_x
                                    for j=1:max_y

                                        if(data1{trail1}(i,j)==0 && data2{trail1}(i,j)==0)
                                            im_data(i,j)=1;
                                        elseif(data1{trail1}(i,j)==0 && data2{trail1}(i,j)==1)
                                            im_data(i,j)=2;
                                        elseif(data1{trail1}(i,j)==1 && data2{trail1}(i,j)==0)
                                            im_data(i,j)=3;
                                        else
                                            im_data(i,j)=4;
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
                                        curr_im_data= im_data(sub2ind([max_x max_y],...
                                            curr_nearby_indices(1,:),curr_nearby_indices(2,:)));

                                        curr_ydata=data1{1}(ind1,ind2);                    %%% Yt
                                        if curr_ydata==0

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

                                pr_x_x_y=counts./total_count;
                                if(sum(pr_x_x_y)~=1)
                                    'error';
                                end

                                if trail1==1
                                    tr_pr{1,ind_tr}= pr_x_x_y;
                                    tr_te(1,ind_tr)=calc_te_new_code(pr_x_x_y,nsymbols);
                                    ind_tr=ind_tr+1;
                                else
                                    sur_pr{1,ind_sr}= pr_x_x_y;
                                    sur_te(1,ind_sr)=calc_te_new_code(pr_x_x_y,nsymbols);
                                    ind_sr=ind_sr+1;
                                end

                            end

                        end
                    end
                end
                %%%% Statistical test %%%%%%%%%%%%%
                mean_tr_te=mean(tr_te);
                mdi= sur_te;         % surro data set %
                cb=1-alpha;          % confidence level%
                ce=cumsum(1/numel(mdi)*ones(1,numel(mdi)));
                smd=sort(mdi,'ascend');
                d_cut=smd(find(ce<=cb,1,'last'));

                curr_pass_or_fail=1;                   %%%% assume that curr_pass_or_fail=1 means significant
                all_pr(lambda_ind1,lambda_ind2)=d_cut;
                pass_or_fail(lambda_ind1,lambda_ind2) = curr_pass_or_fail & (mean_tr_te > d_cut);

                true_prob{lambda_ind1,lambda_ind2}=tr_pr;
                surrogate_prob{lambda_ind1,lambda_ind2}=sur_pr;
                true_te{lambda_ind1,lambda_ind2}=tr_te;
                surrogate_te{lambda_ind1,lambda_ind2}=sur_te;
                toc;
            else
                all_pr(lambda_ind1,lambda_ind2)=NaN;
                pass_or_fail(lambda_ind1,lambda_ind2) = NaN;
                true_prob{lambda_ind1,lambda_ind2}=NaN;
                surrogate_prob{lambda_ind1,lambda_ind2}=NaN;
                true_te{lambda_ind1,lambda_ind2}=NaN;
                surrogate_te{lambda_ind1,lambda_ind2}=NaN;
            end

        end
    end
    save('data_stat_test_submatrix/data_no_lower_firing_all_submatix_4by4.mat','true_te','surrogate_te','true_prob',...
        'surrogate_prob','pass_or_fail','all_pr','firing_y','firing_x')

end