function p = marginal_probabilities(time_series,symbols)
%% Compute probability from time series
for sym_ind=1:length(symbols)
    curr_symbols=find(time_series==symbols(sym_ind));
    p(sym_ind)=length(curr_symbols)/length(time_series);
end