
function auto_corr_mi_comput_function(d,ncell,num_trail,noise_array,nsymbols,num_tau)
tau_array=0:num_tau;
for noise_ind=1:length(noise_array)

    data=load(['symbols/symbols_noise_',num2str(noise_ind),'.mat']);
    data_sym=data.symbols;
    data_real=data.real_value;

    auto_corr=cell(1,num_trail);
    mutual_inf=cell(1,num_trail);

    for trail_ind=1:num_trail
        tic
        corr=zeros(ncell,num_tau);
        mi=zeros(ncell,num_tau);
        for cell1=1:ncell
            parfor tau_ind=1:length(tau_array)
                tau=tau_array(tau_ind);
                corr(cell1,tau_ind)= autocorrelation_function(data_real{trail_ind}(cell1,d:end),tau);
                mi(cell1,tau_ind)= self_mutual_information_function(data_sym{trail_ind}(cell1,d:end),...
                    nsymbols,tau);
            end
        end
        auto_corr{trail_ind}=corr;
        mutual_inf{trail_ind}=mi;
        toc
    end
    save(['corr_mi_data/corr_mi_noise_',num2str(noise_ind),'.mat'],'auto_corr','mutual_inf')
end