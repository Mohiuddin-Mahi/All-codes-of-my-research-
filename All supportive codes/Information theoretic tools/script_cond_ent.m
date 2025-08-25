%%Mohiuddin code:Compute transfer entropy

clc
clear all
close all
%% Input data:
% x =[1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1];            %% x_t time series
% y =[1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1] ;            %% y_t time series
% x =[1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1]+1;            %% x_t time series
% y =[1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1]+1;            %% y_t time series

symbols=[0 1];
nsymbols=6;
load('symbols_6_tmax_5_cpoint_46.mat')
%% Call the function for result:

% [con_ent_x,con_ent_y,p_xy] = con_ent_func(x,y,symbols)
[cond_entropy_x,cond_entropy_y,~]=cond_entropy_function_udoy(symbols{1}(2,2:end),symbols{1}(2,1:end-1),nsymbols)
[con_ent]=entropy_conditioned_by_xt_and_yt_function(symbols{1}(2,:),symbols{1}(1,:),nsymbols,1)