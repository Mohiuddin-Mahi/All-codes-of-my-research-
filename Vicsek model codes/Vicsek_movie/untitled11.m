
clc
close all
clear;

coup_ind=7;
noise_ind=3;

load(['symbols/symbols_r3_box10_coup_',num2str(coup_ind),'_noise_',...
                            num2str(noise_ind),'.mat']);

figure
plot(symbols_real{1}(1,2500:2800),'k','LineWidth',1.5)
hold on
plot(symbols_real{1}(2,2500:2800),'b','LineWidth',1.5)

xlabel('Time (t)','interpreter','latex')
ylabel('Time series','interpreter','latex')
legend('$~X$','$~Y$','location','northeast','interpreter','latex')
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');

figure
plot(symbols_real{1}(1,2500:2800),'k','LineWidth',1.5)
hold on
plot(symbols_real{1}(3,2500:2800),'r','LineWidth',1.5)

xlabel('Time (t)','interpreter','latex')
ylabel('Time series','interpreter','latex')
legend('$~X$','$~Z$','location','northeast','interpreter','latex')
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');
