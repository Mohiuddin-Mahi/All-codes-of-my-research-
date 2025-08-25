


clc
close all
clear;

lstep=5;
frame_ind=400;

font=18;
tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;
lambda_data=1:lstep:71;  

load(['data_te_single_cutoff/te_no_bound_lstep_',num2str(lstep),'_frame_',num2str(frame_ind),...
    '_',num2str(frame_ind+tau),'.mat'])

derivative1_TE=diff(trans_ent)./diff(lambda_data);
derivative2_TE=diff(derivative1_TE)./diff(lambda_data(1:length(lambda_data)-1));

%%% Transfer Entropy %%
figure
h(1)=plot(10*lambda_data,trans_ent,'LineWidth',2.5);
xlim(10*[1 max(lambda_data)])
xlabel('Cutoff distance ($\lambda$)','interpreter','latex')
ylabel(['$T_{' num2str(frame_ind) '\rightarrow' num2str(frame_ind+tau) '}$'],'interpreter','latex')
% xlim([10 1010])
% xticks([10 110 210 310 410 510 610 710 810 910 1010])
% xticklabels({'10','110','210','310','410','510','610','710','810','910','1010'})

xlim([10 710])
xticks([10 60 110 160 210 260 310 360 410 460 510 560 610 660 710])
xticklabels({'10','60','110','160','210','260','310','360','410','460','510','560','610','660','710'})

set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');

%%% 1st derivative of Transfer Entropy%%
figure
h(2)=plot(10*lambda_data(2:end),derivative1_TE,'LineWidth',2.5);
xlim(10*[1 max(lambda_data)])
xlabel('Cutoff distance ($\lambda$)','interpreter','latex')
ylabel(['$\frac{d(T_{' num2str(frame_ind) '\to' num2str(frame_ind+tau) '})}{d\lambda}$'] ,...
    'Interpreter', 'latex');
% xlim([10 1010])
% xticks([10 110 210 310 410 510 610 710 810 910 1010])
% xticklabels({'10','110','210','310','410','510','610','710','810','910','1010'})

xlim([10 710])
xticks([10 60 110 160 210 260 310 360 410 460 510 560 610 660 710])
xticklabels({'10','60','110','160','210','260','310','360','410','460','510','560','610','660','710'})

set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');

% %%% 2nd derivative of Transfer Entropy%%
% figure
% h(3)=plot(10*lambda_data(3:end),derivative2_TE,'LineWidth',2.5);
% xlim(10*[1 max(lambda_data)])
% xlabel('Cutoff distance ($\lambda$)','interpreter','latex')
% ylabel(['$\frac{d^2(T_{' num2str(frame_ind) '\to' num2str(frame_ind+tau) '})}{d\lambda^2}$'] ,...
%     'Interpreter', 'latex');
% xlim([10 710])
% xticks([10 60 110 160 210 260 310 360 410 460 510 560 610 660 710])
% xticklabels({'10','60','110','160','210','260','310','360','410','460','510','560','610','660','710'})
% set(gca,FontSize=font);
% set(gca,'TickLabelInterpreter','latex');

