clear all;clc


max_r=5*sqrt(2);
rad=[linspace(0,5,21) max_r];
r_array=rad;

load('correct_heatmap_r_2.mat')
noise=linspace(0,2*pi,21);
trial_num=1000;
nbird=10;
for  noise_ind=1:length(noise)
    for r_ind=1:length(r_array)
        for trial_ind=1:trial_num
            A1=[];A2=[];A3=[];
            A1=te{trial_ind}{noise_ind}{r_ind};
            A2=tdc{trial_ind}{noise_ind}{r_ind};
            %A3=tdmi{trial_ind}{noise_ind}{r_ind};
            B1=A1';
            B2=A2';
            %B3=A3';
            C1=A1-B1;
            C2=A2-B2;
            %C3=A3-B3;
            net_te{noise_ind,r_ind}(trial_ind,:)=sum(C1,2)/(nbird-1);
            net_tdc{noise_ind,r_ind}(trial_ind,:)=sum(C2,2)/(nbird-1);
            %net_tdmi{noise_ind,r_ind}(trial_ind,:)=sum(C3,2)/(nbird-1);
%             transfer_entropy_l_f{noise_ind}{r_ind}(trial_ind)=mean(w_1_01_5_birds_te{trial_ind}{noise_ind}{r_ind}(1,:));
%             transfer_entropy_f_l{noise_ind}{r_ind}(trial_ind)=mean(w_1_01_5_birds_te{trial_ind}{noise_ind}{r_ind}(:,1));
%             net_transfer_entropy{noise_ind}{r_ind}(trial_ind)=mean(w_1_01_5_birds_te{trial_ind}{noise_ind}{r_ind}(1,:))...
%                 -mean(w_1_01_5_birds_te{trial_ind}{noise_ind}{r_ind}(:,1));
         end
    end
end
clear A1 A2 A3
%save('net_12_lbox_results_200_radius_1000_trials.mat','net_te_12_lbox_200_radius_1000_trials','net_tdc_12_lbox_200_radius_1000_trials')
for noise_ind=1:length(noise)
    parfor r_ind=1:length(r_array)
        tic
        [TPR{noise_ind,r_ind},FPR{noise_ind,r_ind},A1]=ROC_curve_analysis(net_te{noise_ind,r_ind});
        %[~,~,A2]=ROC_curve_analysis(net_tdc{noise_ind,r_ind});
        %[~,~,A3]=ROC_curve_analysis(net_tdmi{noise_ind,r_ind});
        toc
        %AUC_te_10_birds_r_2(noise_ind,r_ind)=A1;
        %AUC_tdc_10_birds_r_2(noise_ind,r_ind)=A2;
        %AUC_tdmi_10_birds_r_3(noise_ind,r_ind)=A3;
    end
end
save('TRP_FPR_chaos_AUC_r_2.mat','TPR','FPR')
