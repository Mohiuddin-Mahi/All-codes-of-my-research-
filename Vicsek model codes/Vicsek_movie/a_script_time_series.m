
clc
close all
clear;

coup_ind=7;
noise_ind=3;

load(['symbols/symbols_r3_box10_coup_',num2str(coup_ind),'_noise_',...
                            num2str(noise_ind),'.mat']);

figure
plot(x_data{1}(1,2500:3100),y_data{1}(1,2500:3100),'LineWidth',1.5)
xlabel('Time (t)','interpreter','latex')
ylabel('$\theta_X$','interpreter','latex')
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');

figure
plot(symbols_real{1}(2,2500:3100),'LineWidth',1.5)
xlabel('Time (t)','interpreter','latex')
ylabel('$\theta_Y$','interpreter','latex')
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');

figure
plot(symbols_real{1}(3,2500:3100),'LineWidth',1.5)
xlabel('Time (t)','interpreter','latex')
ylabel('$\theta_Z$','interpreter','latex')
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');
