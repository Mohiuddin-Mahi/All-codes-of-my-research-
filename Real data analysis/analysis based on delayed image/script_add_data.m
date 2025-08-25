


clc
close all
clear;

lstep=5;

tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;
lambda_array1=1:lstep:71;                             %%lambda_data1=1:10:101;
lambda_array2=1:lstep:71;                             %%lambda_data2=1:10:101;

load(['data_stat_test/mstat_test_lstep_',num2str(lstep),'_frame_500_501_surframe_550_760.mat'])
surrogate_prob1=surrogate_prob;
surrogate_te1=surrogate_te;

load(['data_stat_test/stat_test_lstep_',num2str(lstep),'_frame_500_501_surframe_761_790.mat'])

surrogate_prob2=surrogate_prob;
surrogate_te2=surrogate_te;

all_pr=zeros(length(lambda_array1),length(lambda_array2));
pass_or_fail=zeros(length(lambda_array1),length(lambda_array2));
surrogate_prob=cell(length(lambda_array1),length(lambda_array2));
surrogate_te=cell(length(lambda_array1),length(lambda_array2));

for lambda_ind1=1:length(lambda_array1)
    lambda1=lambda_array1(lambda_ind1);

    for lambda_ind2=1:length(lambda_array2)
        lambda2=lambda_array2(lambda_ind2);

        if lambda1>lambda2
            tic;
            surrogate_prob{lambda_ind1,lambda_ind2}=[surrogate_prob1{lambda_ind1,lambda_ind2} ...
                surrogate_prob2{lambda_ind1,lambda_ind2}];

            surrogate_te{lambda_ind1,lambda_ind2}=[surrogate_te1{lambda_ind1,lambda_ind2} ...
                surrogate_te2{lambda_ind1,lambda_ind2}];

            %%%%%%%%%% statistical test %%%%%%%%%%%%%%%%%
            mdi= surrogate_te{lambda_ind1,lambda_ind2};         % surro data set %
            cb=0.95;          % confidence level%
            ce=cumsum(1/numel(mdi)*ones(1,numel(mdi)));
            smd=sort(mdi,'ascend');
            d_cut=smd(find(ce<=cb,1,'last'));

            curr_pass_or_fail=1;                   %%%% assume that curr_pass_or_fail=1 means significant
            all_pr(lambda_ind1,lambda_ind2)=d_cut;
            pass_or_fail(lambda_ind1,lambda_ind2) = curr_pass_or_fail & (true_te(lambda_ind1,lambda_ind2) > d_cut);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            toc;
        else
            all_pr(lambda_ind1,lambda_ind2)=NaN;
            pass_or_fail(lambda_ind1,lambda_ind2) = NaN;
            surrogate_prob{lambda_ind1,lambda_ind2}=NaN;
            surrogate_te{lambda_ind1,lambda_ind2}=NaN;
        end

    end
end
save(['data_stat_test/mstat_test_lstep_',num2str(lstep),'_frame_500_501_surframe_550_790.mat'],'true_te','surrogate_te','true_prob',...
    'surrogate_prob','pass_or_fail','all_pr')