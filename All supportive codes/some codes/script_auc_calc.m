    clear all;clc
    load('classifier.mat')
    
    clear A1 A2 A3
    %save('net_12_lbox_results_200_radius_1000_trials.mat','net_te_12_lbox_200_radius_1000_trials','net_tdc_12_lbox_200_radius_1000_trials')
    for noise_ind=1:length(noise)
       
            tic
            [~,~,AUC_TE(noise_ind)]=ROC_curve_analysis(TE_classifier{noise_ind});
             [~,~,AUC_intrinsic(noise_ind)]=ROC_curve_analysis(intrinsic_classifier{noise_ind});
              [~,~,AUC_shared(noise_ind)]=ROC_curve_analysis(shared_classifier{noise_ind});
               [~,~,AUC_synergistic(noise_ind)]=ROC_curve_analysis(synergistic_classifier{noise_ind});
                [~,~,AUC_TDMI(noise_ind)]=ROC_curve_analysis(TDMI_classifier{noise_ind});
            toc
           
       
    end
    