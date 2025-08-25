

clc
close all
clear;

noise=4;

font=14;
num_tau=50;
tau_array=0:num_tau;
noise_array=[0.3 0.6 0.9 1.2 1.5 1.8];

load(['corr_mi_data/corr_mi_noise_',num2str(noise),'.mat'])

figure
plot(tau_array,auto_corr{1}(1,:),'linewidth',1.5)
hold on
plot(tau_array,auto_corr{1}(1,:),'linewidth',1.5)
yline(1/exp(1),'--k','LineWidth',1.5);
xlabel('Time delay $(\tau)$ ','interpreter','latex')
ylabel('ACF($\tau$)','interpreter','latex')
title(['$\eta$ = ',num2str(noise_array(noise)),'$\pi$'], 'interpreter','latex')
legend('$Cell1$','$Cell2$','$1/e$','location','northeast','interpreter','latex')
xlim([0 50])
% ylim([0 1])
set(gca,FontSize=14);
set(gca,'TickLabelInterpreter','latex');

figure
plot(tau_array,mutual_inf{1}(1,:),'linewidth',1.5)
hold on
plot(tau_array,mutual_inf{1}(1,:),'linewidth',1.5)
yline(1/exp(1),'--k','LineWidth',1.5);
xlabel('Time delay $(\tau)$ ','interpreter','latex')
ylabel('Self-mutual inf.($\tau$)','interpreter','latex')
title(['$\eta$ = ',num2str(noise_array(noise)),'$\pi$'], 'interpreter','latex')
legend('$Cell1$','$Cell2$','$1/e$','location','northeast','interpreter','latex')
xlim([0 50])
% ylim([0 2.585])
set(gca,FontSize=14);
set(gca,'TickLabelInterpreter','latex');
