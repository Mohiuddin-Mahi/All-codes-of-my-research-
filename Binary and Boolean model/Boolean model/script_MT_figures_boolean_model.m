

clc
close all
clear;

theta=2;

font=18;
nbird=3;
tau_max=4;
num_coup=11;
num_theta=11;

theta_array=linspace(0,0.25,num_theta);
coup_array=linspace(0,1,num_coup);


%%%%%%%%%%%%% Figure %%%%%%%%%%%%%%%%


figure
load('data_te/data_birds_1_2.mat')
for tau_ind=1:tau_max
    plot(coup_array,tran_ent_new{tau_ind}(theta,:),'LineWidth',2.5)
    hold on
end
xlabel('$\gamma$ ','interpreter','latex')
ylabel('$MT_{X\rightarrow Y}$','interpreter','latex')
title(['$\Theta$ = ',num2str(theta_array(theta))], 'interpreter','latex')
legend('${\tau=1}$','${\tau=2}$','${\tau=3}$','${\tau=4}$','location','northwest','interpreter','latex')
xlim([0 1])
% xticks([0 0.4 0.8 1.2 1.6 2])
% xticklabels({'0','0.4','0.8','1.2','1.6','2'})
% ylim([0 0.35])
% yticks([0 0.05 0.10 0.15 0.20 0.25 0.30 0.35])
% yticklabels({'0','0.05','0.10','0.15','0.20','0.25','0.30','0.35'})
set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');



figure
load('data_te/data_birds_2_3.mat')
for tau_ind=1:tau_max
    plot(coup_array,tran_ent_new{tau_ind}(theta,:),'LineWidth',2.5)
    hold on
end
xlabel('$\gamma$ ','interpreter','latex')
ylabel('$MT_{Y\rightarrow Z}$','interpreter','latex')
title(['$\Theta$ = ',num2str(theta_array(theta))], 'interpreter','latex')
legend('${\tau=1}$','${\tau=2}$','${\tau=3}$','${\tau=4}$','location','northwest','interpreter','latex')
xlim([0 1])
% xticks([0 0.4 0.8 1.2 1.6 2])
% xticklabels({'0','0.4','0.8','1.2','1.6','2'})
% ylim([0 0.35])
% yticks([0 0.05 0.10 0.15 0.20 0.25 0.30 0.35])
% yticklabels({'0','0.05','0.10','0.15','0.20','0.25','0.30','0.35'})
set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');


figure
load('data_te/data_birds_1_3.mat')
for tau_ind=1:tau_max
    plot(coup_array,tran_ent_new{tau_ind}(theta,:),'LineWidth',2.5)
    hold on
end
xlabel('$\gamma$ ','interpreter','latex')
ylabel('$MT_{X\rightarrow Z}$','interpreter','latex')
title(['$\Theta$ = ',num2str(theta_array(theta))], 'interpreter','latex')
legend('${\tau=1}$','${\tau=2}$','${\tau=3}$','${\tau=4}$','location','northwest','interpreter','latex')
xlim([0 1])
% xticks([0 0.4 0.8 1.2 1.6 2])
% xticklabels({'0','0.4','0.8','1.2','1.6','2'})
% ylim([0 0.35])
% yticks([0 0.05 0.10 0.15 0.20 0.25 0.30 0.35])
% yticklabels({'0','0.05','0.10','0.15','0.20','0.25','0.30','0.35'})
set(gca,FontSize=font);
set(gca,'TickLabelInterpreter','latex');