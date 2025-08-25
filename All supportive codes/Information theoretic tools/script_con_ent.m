
%%Mohiuddin Code:Compute conditional entropy from time series:
clc
clear all
close all
%% Input Data:
x=[1 1 1 0 1 0 1 1];
y=[0 1 0 0 1 0 1 0];
%% How many symbols do you have in your data?
symbols=[0 1];

%% Call the function for result:
[con_ent_x,con_ent_y] = con_ent_func(x,y,symbols)