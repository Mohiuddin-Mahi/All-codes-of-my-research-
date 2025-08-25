%% Mohiuddin code:Mutual information
clc
clear all
close all
%% Input data:
x=[1 1 1 0 1 0 1 1];
y=[0 1 0 0 1 0 1 0];
%%How many symbols do you have in your data?
symbols=[0 1];

%% Call the function for result:
mutual_inform=mutual_inform_func(x,y,symbols)