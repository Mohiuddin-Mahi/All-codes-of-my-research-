function [p_x,p_y,p_xy] = joint_probabilities(time_series1,time_series2,symbols1,symbols2)
%% Compute probability from time series
p=zeros(length(symbols1),length(symbols2));           %% For large data pc may be slow so this statement is used to make the pc faster


for sym_ind1=1:length(symbols1)
    for sym_ind2=1:length(symbols2)
        curr_symbols_x=find(time_series1==symbols1(sym_ind1));
        curr_symbols_y=find(time_series2==symbols2(sym_ind2));
        curr_symbols_xy=find(time_series1==symbols1(sym_ind1) & time_series2==symbols2(sym_ind2));
        p_x(sym_ind1)=length(curr_symbols_x)/length(time_series1); 
        p_y(sym_ind2)=length(curr_symbols_y)/length(time_series2); 
        p_xy(sym_ind1,sym_ind2)=length(curr_symbols_xy)/length(time_series1);           %% It can also be divide by length(time_series2)
    end
end


