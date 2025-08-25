

clc
close all
clear;

lstep=5;
frame_ind=500;

lambda1=12;
lambda2=11;

font=16;
tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;

lambda_data1=1:lstep:71;
lambda_data2=1:lstep:71;
load(['data_stat_test/stat_test_lstep_',num2str(lstep),'_frame_',num2str(frame_ind),...
    '_',num2str(frame_ind+tau),'_surframe_550_640.mat'])

mdi= surrogate_te{lambda1,lambda2};     % surro data set %
cb=0.95;              % confidence level%
ce=cumsum(1/numel(mdi)*ones(1,numel(mdi)));
smd=sort(mdi,'ascend');
d_cut=smd(find(ce<=cb,1,'last'));

figure
histogram(mdi,20,'normalization','probability')
hold on
h(1)=plot([d_cut d_cut],[0 0.5],'-r','linewidth',2);
hold on
h(2)=plot([true_te(lambda1,lambda2) true_te(lambda1,lambda2)],[0 0.5],'-b','linewidth',2);
xlabel('Surrogate data','interpreter','latex')
ylabel('Probaility','interpreter','latex')
set(gca,FontSize=font);


