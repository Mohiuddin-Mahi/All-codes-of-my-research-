

clc
close all
clear;

cell1=1;
cell2=2;

noise=3;


r=1;
ncell=2;
font=20;
nsymbols=6;
num_lamda=11;
max_lambda=2;
lambda1=linspace(0,max_lambda,num_lamda);
lambda2=linspace(0,max_lambda,num_lamda);
load(['data_te/te_cell_',num2str(cell1),'_',num2str(cell2),'_noise_',num2str(noise),'.mat'])



derivative1_te=diff(tran_ent(:,1))./diff(lambda1);

%% TE figure %%
figure
plot(lambda1,tran_ent(:,1),'linewidth',2.5)
xlabel('Cutoff distance $(\lambda_1)$ ','interpreter','latex')
ylabel('$T_{ X~\rightarrow Y}$','interpreter','latex')
xlim([0 2])
set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');


%% 1st derivative %%
figure
plot(lambda1(2:end),derivative1_te,'linewidth',2.5)
xlabel('Cutoff distance $(\lambda_1)$ ','interpreter','latex')
ylabel('$dT_{ X~\rightarrow Y}/d\lambda_1$','interpreter','latex')
xlim([0 2])
set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');
