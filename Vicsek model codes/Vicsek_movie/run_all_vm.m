

clc
close all
clear;

r=3;               % r refers to the nteraction radius in VM
dt=1;              % dt is interacting time delay     
vs=0.3;            % vs is constant velocity of agents in VM          
lbox=10;           % L is length of simulation box
nbird=3;           % nbird is number of agents in VM
tmax=1e5;          % tmax is simulation time length
nsymbols=6;        % nsymbols is number of bin in discretization
num_trail=5;      % num_trail is number of observation 

coup_max=1;        % coup_max is maximum value of coupling strength
coup_min=0.1;      % coup_min is minimum value of coupling strength
num_noise=10;      % num_noise is number of noise interval 
num_coupling=10;   % num_coupling is number of coupling interval
noise_min=pi/10;   % noise_min is minimum value of noise
noise_max=19*pi/10;% noise_max is maximum value of noise

%%%% simulate data %%%%

function_symbols_vm(tmax,r,dt,vs,lbox,nbird,nsymbols,num_trail,num_noise,num_coupling,coup_min,...
    coup_max,noise_min,noise_max)

% %%%%% movie %%%
% initial_time_step=2500;
% final_time_step=4000;
% function_movie_vm(lbox,initial_time_step,final_time_step)
