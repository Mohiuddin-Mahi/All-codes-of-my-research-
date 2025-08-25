
function script_transfer_entropy_comput_boolean_model()

clc
close all
clear;

nbird=3;
tmax=2e6;
tau_max=4;
nsymbols=2;
num_trail=20;
num_theta=11;
num_coupling=11;
tau_array=1:tau_max;
theta_array=linspace(0,0.25,num_theta);
coup_array=linspace(0,1,num_coupling);
d=round((5*tmax)/100);

for bird1=1:nbird
    for bird2=1:nbird
        if (bird1~=bird2)

            tran_ent=cell(1,length(tau_array));
            tran_ent_new=cell(1,length(tau_array));

            for tau_ind=1:length(tau_array)
                tau=tau_array(tau_ind);

                for theta_ind=1:length(theta_array)
                    for coup_ind=1:length(coup_array)

                        load(['symbols/symbols_theta_',num2str(theta_ind),'_coup_',...
                            num2str(coup_ind),'.mat'],'symbols');
                        tic;
                        temp=zeros(1,num_trail);
                        temp_new=zeros(1,num_trail);

                        parfor trail_ind=1:num_trail
                            temp(1,trail_ind)=tran_ent_func_mohi(symbols{trail_ind}(bird2,d:end),...
                                symbols{trail_ind}(bird1,d:end),nsymbols,tau);

                            temp_new(1,trail_ind)=tran_ent_func_mohi_new(symbols{trail_ind}(bird2,d:end),...
                                symbols{trail_ind}(bird1,d:end),nsymbols,tau);
                        end

                        tran_ent{tau_ind}(theta_ind,coup_ind)=mean(temp,2);
                        tran_ent_new{tau_ind}(theta_ind,coup_ind)=mean(temp_new,2);
                        toc;
                    end
                end

            end
            save(['data_te/data_birds_',num2str(bird1),'_',num2str(bird2),'.mat'],'tran_ent','tran_ent_new')
        end
    end
end
