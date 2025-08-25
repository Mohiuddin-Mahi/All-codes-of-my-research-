
clc
close all
clear;

coup_ind=7;
noise_ind=3;
num_symbols=6;

load(['symbols/symbols_r3_box10_coup_',num2str(coup_ind),'_noise_',...
                            num2str(noise_ind),'.mat']);

%%% Histogram of uniform width discretization %%%%%%

symbols_width=get_symbol_strings(symbols_real{1}(:,2500:3100),num_symbols);

figure
histogram(symbols_width(1,:),'LineWidth',1.5)
xlabel('Number of bins','interpreter','latex')
ylabel('Frequency','interpreter','latex')
title('Discretization of $\theta_X$ by uniform width','interpreter','latex')
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');


%%% Histogram of uniform frequency discretization %%%%%%

symbols_frequency=get_symbol_string_by_frequency(symbols_real{1}(:,2500:3100),num_symbols);

figure
histogram(symbols_frequency(1,:),'LineWidth',1.5)
xlabel('Number of bins','interpreter','latex')
ylabel('Frequency','interpreter','latex')
title('Discretization of $\theta_X$ by uniform frequency','interpreter','latex')
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');