%%Mohiuddin code:Compute time delayed mutual information from time series:

clc
clear all
close all
%% Input data:
x =[1 1 1 1 0 0 1 0 1 0 1] ;                      %% x_t time series
y =[1 0 1 1 1 0 1 0 0 0 1] ;                      %% y_t time series

y1 =[1 1 1 1 0 0 1 0 1 0 1]+1 ;                      %% x_t time series
x1 =[1 0 1 1 1 0 1 0 0 0 1]+1 ;                      %% y_t time series
tau=1;                                            %% time delay/time lag of y_t
k=1;
l=1;
d=1;

%% How many symbols in your data:
symbols=[0 1];
nsymbols=2;
%% Call the function for result:
TDMI_x_y= tdmi_function(x,y,tau,symbols)
[tdmi_y_x]=tdmi_function_udoy(x1,y1,nsymbols,k,l,d)