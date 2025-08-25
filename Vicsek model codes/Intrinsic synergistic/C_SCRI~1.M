

clc; clear all

num_noise=40;
num_trail=20;
leader_weight_array=[1,10,100,1000,10000,100000];
nbird=3;
noise_array=linspace(0,2*pi,num_noise);

%%% Preallocation %%%

intrinsic=zeros(length(noise_array),num_trail);
r_intrinsic=zeros(length(noise_array),num_trail);
shared=zeros(length(noise_array),num_trail);
r_shared=zeros(length(noise_array),num_trail);
synergistic=zeros(length(noise_array),num_trail);
r_synergistic=zeros(length(noise_array),num_trail);
transfer_entropy=zeros(length(noise_array),num_trail);
r_transfer_entropy=zeros(length(noise_array),num_trail);
TDMI=zeros(length(noise_array),num_trail);
r_TDMI=zeros(length(noise_array),num_trail);

for weight_ind=1:length(leader_weight_array)
    leader_weight=leader_weight_array(weight_ind);

    str1='intrinsic_'; str2='r_intrinsic_'; str3='shared_'; str4='r_shared_'; str5='synergistic_'; str6='r_synergistic_';
    str7='Transfer_entropy_'; str8='r_Transfer_entropy_'; str9='TDMI_'; str10='r_TDMI_';
    
    for noise_ind=1:length(noise_array)

        load(['results_weight_',num2str(leader_weight),'_noise_',num2str(noise_ind),'_1_',num2str(nbird),'_',num2str(noise_ind),'.mat']);
%         load(['results_weight_',num2str(leader_weight),'_noise_',num2str(noise_ind),'_1_2_',num2str(noise_ind),'.mat']);
                    
        intrinsic(noise_ind,:)=eval([str1,num2str(noise_ind)]);
        r_intrinsic(noise_ind,:)=eval([str2,num2str(noise_ind)]);
        shared(noise_ind,:)=eval([str3,num2str(noise_ind)]);
        r_shared(noise_ind,:)=eval([str4,num2str(noise_ind)]);
        synergistic(noise_ind,:)=eval([str5,num2str(noise_ind)]);
        r_synergistic(noise_ind,:)=eval([str6,num2str(noise_ind)]);
        transfer_entropy(noise_ind,:)=eval([str7,num2str(noise_ind)]);
        r_transfer_entropy(noise_ind,:)=eval([str8,num2str(noise_ind)]);
        TDMI(noise_ind,:)=eval([str9,num2str(noise_ind)]);
        r_TDMI(noise_ind,:)=eval([str10,num2str(noise_ind)]);

        clearvars -except  intrinsic r_intrinsic shared r_shared synergistic r_synergistic transfer_entropy r_transfer_entropy TDMI...
        r_TDMI str1 str2 str3 str4 str5 str6 str7 str8 str9 str10 leader_weight_array noise_array leader_weight nbird
                                  
    end
    clear str1 str2 str3 str4 str5 str6 str7 str8 str9 str10
    save(['Data_W_LF_',num2str(leader_weight),'_birds_1_',num2str(nbird),'.mat']) 
%     save(['Data_W_LF_',num2str(leader_weight),'_birds_1_2.mat']) 
end
