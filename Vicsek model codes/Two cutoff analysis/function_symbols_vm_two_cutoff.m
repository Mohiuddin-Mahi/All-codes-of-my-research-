
function function_symbols_vm_two_cutoff(dt,ncell,tmax,num_trail,lbox,r,vs,noise_array,nsymbols,coupling_strength)
                                
%%%%%%%%%%%%%%%%%% wmatrix %%%%%%%%%%%%%%%%%%%%%%
num_leader=1;
wmatrix=ones(ncell);
wmatrix(num_leader+1:end,1:num_leader)=coupling_strength;
wmat=wmatrix;

%%%%%%%%%%%%% Time series computation %%%%%%%%%%%

for noise_ind=2:length(noise_array)
    eta=noise_array(noise_ind);

    parfor trail_ind=1:num_trail
        tic
        [theta_out,x_out,y_out] = modified_VM_multi_updated(lbox,vs,dt,r,eta,ncell,tmax,wmat)
        x_value{trail_ind}=x_out;
        y_value{trail_ind}=y_out;
        real_value{trail_ind}=theta_out;
        symbols{trail_ind}=get_symbol_strings(theta_out,nsymbols);
        toc
    end
    save(['symbols/symbols_noise_',num2str(noise_ind)],'symbols','real_value','x_value','y_value','-v7.3')

end
end