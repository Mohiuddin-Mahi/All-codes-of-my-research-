
function function_autocorr_data_fitting_vm(num_trail,noise_array)

for noise_ind=1:length(noise_array)

    load(['corr_mi_data/corr_mi_noise_',num2str(noise_ind),'.mat'],'auto_corr');
    tic;
    params=cell(1,num_trail);
    fitted_corr=cell(1,num_trail);
    for trail_ind=1:num_trail
        [temp1,temp2]=lscurvefitting_function_vm(auto_corr{trail_ind});
        params{trail_ind}=temp2;
        fitted_corr{trail_ind}=temp1;
    end
    toc;
    save(['corr_data_fit/corr_noise_',num2str(noise_ind),'.mat'],'params','fitted_corr')
end

end

