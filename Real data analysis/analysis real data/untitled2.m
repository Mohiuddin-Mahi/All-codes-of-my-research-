



clc
close all
clear;

lstep=5;

font=18;
tau=1;
row_ind=1;
col_ind=1;
nsymbols=2;
resize_param=0.1;
lambda_data=1:lstep:71;  

load(['data_te_single_cutoff/te_no_bound_lstep_',num2str(lstep),'_frame_400_401.mat'])
trans_ent1=trans_ent;
derivative1_TE=diff(trans_ent1)./diff(lambda_data);

load(['data_te_single_cutoff/te_no_bound_lstep_',num2str(lstep),'_frame_500_501.mat'])
trans_ent2=trans_ent;
derivative2_TE=diff(trans_ent2)./diff(lambda_data);

load(['data_te_single_cutoff/te_no_bound_lstep_',num2str(lstep),'_frame_600_601.mat'])
trans_ent3=trans_ent;
derivative3_TE=diff(trans_ent3)./diff(lambda_data);




%%% Transfer Entropy %%%
figure
plot(10*lambda_data, trans_ent1,'-square', 'LineWidth', 2.5, 'Color', [0, 0.4470, 0.7410]); % blue
hold on
plot(10*lambda_data, trans_ent2,'-diamond', 'LineWidth', 2.5, 'Color', [0.8500, 0.3250, 0.0980]); % orange
plot(10*lambda_data, trans_ent3,'-o', 'LineWidth', 2.5, 'Color', [1 0 0]); % red
xlim(10*[1 max(lambda_data)])
xlabel('Cutoff distance ($\lambda$)~$\mu$m','interpreter','latex')
ylabel('$TE$','interpreter','latex')
legend('$TE_{400 \to 401}$','$TE_{500 \to 501}$','$TE_{600 \to 601}$','location','northeast','interpreter','latex')
xlim([10 710])
xticks([10 60 110 160 210 260 310 360 410 460 510 560 610 660 710])
xticklabels({'10','60','110','160','210','260','310','360','410','460','510','560','610','660','710'})
set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');


%%% 1st derivative of Transfer Entropy%%%
figure
plot(10*lambda_data(2:end),derivative1_TE,'-square', 'LineWidth', 2.5, 'Color', [0, 0.4470, 0.7410]);
hold on
plot(10*lambda_data(2:end),derivative2_TE,'-diamond', 'LineWidth', 2.5, 'Color', [0.8500, 0.3250, 0.0980]);
plot(10*lambda_data(2:end),derivative3_TE,'-o', 'LineWidth', 2.5, 'Color', [1 0 0]);
xlim(10*[1 max(lambda_data)])
xlabel('Cutoff distance ($\lambda$)~$\mu$m','interpreter','latex')
ylabel('$\frac{d(TE)}{d\lambda}$','Interpreter', 'latex');
legend('$dTE_{400 \to 401}$','$dTE_{500 \to 501}$','$dTE_{600 \to 601}$','location','northeast','interpreter','latex')
xlim([10 710])
xticks([10 60 110 160 210 260 310 360 410 460 510 560 610 660 710])
xticklabels({'10','60','110','160','210','260','310','360','410','460','510','560','610','660','710'})
set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');


