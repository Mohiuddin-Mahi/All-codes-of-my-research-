
%Mohiuddin
% x_t is a fair coin toss
% y_(t+1) is x_t with pr '1-d' or 0 with pr d/2 or 1 with pr d/2 for d<R and  
%y_(t+1) is a fair coin toss for d>=R. 

clc
clear all
%% Input data
TMAX=10;          %% Time steps
R=1;              %% interaction radius
a=0.5;            %% Since the probability is an arbitrary variable so choose a fixed probability value
%% Call function
[x_t,y_t]=binary_model2_function(TMAX,R)





