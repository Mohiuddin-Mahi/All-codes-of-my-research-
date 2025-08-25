
clc
close all
clear;

r=1;
dt=1;
tau=1;
vs=0.3;
lbox=10;
ncell=2;
tmax=5e6;
alpha=0.05;
nsymbols=6;
num_trail=30;
max_lambda=2;
num_lambda=11;
coupling_strength=1.5;
d=round((5*tmax)/100);
noise_array=[0.3*pi 0.6*pi 0.9*pi 1.2*pi 1.5*pi 1.8*pi];

%%%% Symbols generation %%%

function_symbols_vm_two_cutoff(dt,ncell,tmax,num_trail,lbox,r,vs,noise_array,nsymbols,coupling_strength)

%%%%% Estimation of autocorrelation and mutual information %%%%%%%%
num_tau=50;
auto_corr_mi_comput_function(d,ncell,num_trail,noise_array,nsymbols,num_tau)

%%%% Estimation of TE %%%%%%%%

tran_ent_computation_two_cutoff(d,tau,lbox,ncell,num_trail,noise_array,nsymbols,num_lambda,max_lambda)

%%%%%%%%% Statistical Test %%%%%

function_stat_test_two_cutoff(d,tau,lbox,ncell,num_trail,noise_array,nsymbols,num_lambda,...
    max_lambda,alpha)



