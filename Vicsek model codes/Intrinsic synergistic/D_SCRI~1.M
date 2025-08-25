
clc; clear all

num_noise=40;
num_trail=20;
nbird=3;
leader_weight_array=[1,10,100,1000,10000,100000]; 
noise_array=linspace(0,2*pi,num_noise);

%% Preallocation %%%

intrinsic_L_F=cell(1,length(leader_weight_array));
intrinsic_F_L=cell(1,length(leader_weight_array));
synergistic_L_F=cell(1,length(leader_weight_array));
synergistic_F_L=cell(1,length(leader_weight_array));
transfer_entropy_L_F=cell(1,length(leader_weight_array));
transfer_entropy_F_L=cell(1,length(leader_weight_array));
TDMI_L_F=cell(1,length(leader_weight_array));
TDMI_F_L=cell(1,length(leader_weight_array));
shared_L_F=cell(1,length(leader_weight_array));
shared_F_L=cell(1,length(leader_weight_array));

for b_ind=1:length(leader_weight_array)
    leader_weight=leader_weight_array(b_ind);
    load(['Data_W_LF_',num2str(leader_weight),'_birds_1_',num2str(nbird),'.mat'])
%     load(['Data_W_LF_',num2str(leader_weight),'_birds_1_2.mat'])

    transfer_entropy_L_F{b_ind}=transfer_entropy;
    transfer_entropy_F_L{b_ind}=r_transfer_entropy;

    TDMI_L_F{b_ind}=TDMI;
    TDMI_F_L{b_ind}=r_TDMI;
    
    intrinsic_L_F{b_ind}=intrinsic;
    intrinsic_F_L{b_ind}=r_intrinsic;

    synergistic_L_F{b_ind}=synergistic;
    synergistic_F_L{b_ind}=r_synergistic;

    shared_L_F{b_ind}=shared;
    shared_F_L{b_ind}=r_shared;
end

%%%%% Figure:Transfer entropy

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(transfer_entropy_L_F{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('TE_L_\rightarrow_F')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 0.18])
% % yticks([0 0.05 0.1 0.15])
% % % % % % yticklabels({'0','0.5','1','1.5','2'})

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(transfer_entropy_F_L{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('TE_F_\rightarrow_L')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 0.18])
% % yticks([0 0.05 0.1 0.15])
% % % % % yticklabels({'0','0.5','1','1.5','2'})

% Figure:TDMI

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(TDMI_L_F{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('TDMI_L_\rightarrow_F')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 2.3])
% % yticks([0 0.5 1 1.5 2])
% % % % yticklabels({'0','0.5','1','1.5','2'})
 

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(TDMI_F_L{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('TDMI_F_\rightarrow_L')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 2.3])
% % yticks([0 0.5 1 1.5 2])
% % % % % yticklabels({'0','0.5','1','1.5','2'})

%% Figure Intrinsic

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(intrinsic_L_F{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('I_L_\rightarrow_F')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 0.18])
% % yticks([0 0.05 0.1 0.15])
% % % % % yticklabels({'0','0.5','1','1.5','2'})

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(intrinsic_F_L{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('I_F_\rightarrow_L')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 0.18])
% % yticks([0 0.05 0.1 0.15])
% % % % % yticklabels({'0','0.5','1','1.5','2'})

% FIGURE SYNERGISTIC
figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(synergistic_L_F{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('S_L_\rightarrow_F')
% % legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 0.02])
% % yticks([0 0.005 0.01 0.015 0.02])
% % % % % yticklabels({'0','0.5','1','1.5','2'})

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(synergistic_F_L{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('S_F_\rightarrow_L')
% % % legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% ylim([0 0.02])
% yticks([0 0.005 0.01 0.015 0.02])
% % % % yticklabels({'0','0.5','1','1.5','2'})

%%% Figure shared
figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(shared_L_F{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('\sigma_L_\rightarrow_F')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 2])
% % yticks([0 0.5 1 1.5 2])
% % % % % yticklabels({'0','0.5','1','1.5','2'})

figure;
for num_bird=1:length(leader_weight_array)
    plot(noise_array,mean(shared_F_L{num_bird},2))
    hold on
end
xlabel('Noise (\eta_0)')
ylabel('\sigma_F_\rightarrow_L')
% legend(['N_b = ',num2str(nbird_array(1))],['N_b = ',num2str(nbird_array(2))],['N_b = ',num2str(nbird_array(3))])
legend('W_L_F=1', 'W_L_F=10','W_L_F=100','W_L_F=1000', 'W_L_F=10000','W_L_F=100000')
xlim([0 2*pi])       %% Replace of xlim and ylim we can write the command axis([0 2*pi 0 2])
xticks([0*pi 0.5*pi pi 1.5*pi 2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
% % ylim([0 2])
% % yticks([0 0.5 1 1.5 2])
% % % % % yticklabels({'0','0.5','1','1.5','2'})
