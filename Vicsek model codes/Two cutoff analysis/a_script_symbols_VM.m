
%%% Script to generate theta_out,x_val,y_val from modified_VM_multi_updated %%%%%%%

clc
close all
clear;

r=1;                                 %%% r is interaction radius
dt=1;
vs=0.3;
lbox=10;
ncell=2;                             %%% 2 cells X, and Y
TMAX=2e6;                            %%% TMAX=2e6 in Sci.adv. paper   
nsymbols=6;
num_trail=100;
num_leader=1;
leader_weight=4;
noise_array=[0.1*pi, 0.3*pi, 0.6*pi, 1.2*pi, 1.8*pi];

%%%%%%%%%%%%%%%%%% wmatrix %%%%%%%%%%%%%%%%%%%%%%

wmatrix=ones(ncell);
wmatrix(num_leader+1:end,1:num_leader)=leader_weight;
wmat=wmatrix;

%%%%%%%%%%%%% Time series computation %%%%%%%%%%%

for noise_ind=1%:length(noise_array)
    eta=noise_array(noise_ind);

    parfor trail_ind=1:num_trail
        tic
        [theta_out,x_out,y_out] = modified_VM_multi_updated(lbox,vs,dt,r,eta,ncell,TMAX,wmat)
        symbols{trail_ind}=get_symbol_strings(theta_out,nsymbols);
        symbols_real{trail_ind}=theta_out;
        x_value{trail_ind}=x_out;
        y_value{trail_ind}=y_out;
        toc
    end
    save(['symbols/symbols_noise_',num2str(noise_ind)],'symbols_real','symbols','x_value','y_value','-v7.3')
     
end