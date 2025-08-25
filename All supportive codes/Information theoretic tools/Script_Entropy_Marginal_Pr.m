%% Compute marginal probability and entropy from time series:
clc
clear all

time_series=[1 2 3 4];
symbols=[1 2 3 4];
p = marginal_probabilities(time_series,symbols)
[H,H1] = Entropy_func(p)
