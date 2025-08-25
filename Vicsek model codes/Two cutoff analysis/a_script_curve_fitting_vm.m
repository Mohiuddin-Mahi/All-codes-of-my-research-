

clc
close all
clear;

noise_ind=3;

% % % initial_guess = [0.5, 1, 0.6283, 0];   %%% Appropriate initial guess for all data and for bisection method results

initial_guess = [0.1, 1, 0];


noise_array=[0.3 0.6 0.9 1.2 1.5 1.8];

%% Input data
x = linspace(0, 70, 71); 
load(['corr_mi_data/corr_mi_noise_',num2str(noise_ind),'.mat'],'auto_corr')
y1 = auto_corr{1}(1,:); 
y2 = auto_corr{1}(2,:); 

% Define the model function for exponentially decreasing curve

exp_decreasing = @(b, x)  ((exp(-b(1)*x).*b(2)+b(3))/(b(2)+b(3)));

% Perform the curve fitting using non-linear least squares
params1 = lsqcurvefit(exp_decreasing, initial_guess, x, y1);
params2 = lsqcurvefit(exp_decreasing, initial_guess, x, y2);

% Generate fitted curve using the optimized parameters
y1_fitted = exp_decreasing(params1, x);
tau1=1/params1(1);

y2_fitted = exp_decreasing(params2, x);
tau2=1/params2(1);

figure
plot(x, y1, 'b-');
hold on;
plot(x, y1_fitted, 'b--', 'LineWidth', 2);
plot(x, y2, 'm-', 'DisplayName', 'Original Data');
plot(x, y2_fitted, 'm--', 'LineWidth', 2, 'DisplayName', 'Fitted Exponential Decay');
yline(1/exp(1),'--k','LineWidth',1.5, 'DisplayName', 'Threshold');

legend('Original Data','Fitted curve','Original Data','Fitted curve',...
    'location','northeast','interpreter','latex')
xlabel('Time lags($t_l$)','interpreter','latex');
ylabel('ACF($t_l$)','interpreter','latex');
title(['$\eta=$',num2str(noise_array(noise_ind)),'$\pi$'],'interpreter','latex')
xlim([0 70])
set(gca,FontSize=16);
set(gca,'TickLabelInterpreter','latex');