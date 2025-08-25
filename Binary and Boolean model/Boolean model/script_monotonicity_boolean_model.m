
function script_monotonicity_boolean_model()

clc
close all
clear;

nbird=3;
tau_max=4;
num_cprob=11;
num_coupling=11;

for ind1=1:nbird
    for ind2=1:nbird
        if ind1~=ind2

            load(['data_te/data_birds_',num2str(ind1),'_',num2str(ind2),'.mat'],'tran_ent','tran_ent_new')

            tr_ent=cell(num_cprob,num_coupling);
            tr_ent_new=cell(num_cprob,num_coupling);

            for tau_ind=1:tau_max
                for cprob_ind=1:num_cprob
                    for coup_ind=1:num_coupling
                        tr_ent{cprob_ind,coup_ind}(1,tau_ind)=tran_ent{tau_ind}(cprob_ind,coup_ind);
                        tr_ent_new{cprob_ind,coup_ind}(1,tau_ind)=tran_ent_new{tau_ind}(cprob_ind,coup_ind);
                    end
                end
            end

            %%%%% monotonic test %%%%

            mon_te=zeros(num_cprob,num_coupling);
            mon_te_new=zeros(num_cprob,num_coupling);

            for cprob_ind=1:num_cprob
                for coup_ind=1:num_coupling
                    mon_te(cprob_ind,coup_ind)=function_cycleSort_monotonicity_test(tr_ent{cprob_ind,coup_ind});
                    mon_te_new(cprob_ind,coup_ind)=function_cycleSort_monotonicity_test(tr_ent_new{cprob_ind,coup_ind});
                end
            end

            save(['data_te/data_monot_test_cycle_sort_birds_',num2str(ind1),'_',num2str(ind2),'.mat'],...
                'mon_te','mon_te_new')

        end
    end
end


