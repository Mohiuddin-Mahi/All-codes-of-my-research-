%%Mohiuddin code:Compute transfer entropy

clc
clear all
close all
%% Input data:
tau=1;
symbols=[1 2];
nsymbols=2;
k=1;l=1;d=1;
%%% time series for my code %%%
x =[0, 1, 0, 0, 1, 0, 1, 1, 0]+1;             %% x_t time series
y =[1, 1, 1, 0, 1, 0, 0, 1, 1]+1;             %% y_t time series
[TE_x_y] = transfer_ent_function_mohi(x,y,tau,symbols)

%%% time series for udoy code %%%%%
y1 =[0, 1, 0, 0, 1, 0, 1, 1, 0]+1;             %% x_t time series
x1 =[1, 1, 1, 0, 1, 0, 0, 1, 1]+1;             %% y_t time series
[tr_en1]=transfer_entropy_function_udoy(x1,y1,nsymbols,k,l,d)


