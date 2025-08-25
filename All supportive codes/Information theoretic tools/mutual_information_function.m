%% Mohiuddin code:
function [mutual_inform]=mutual_information_function(x,y,symbols)
p_x=zeros(length(symbols)); 
p_y=zeros(length(symbols)); 
p_xy=zeros(length(symbols),length(symbols)); 

%% Compute probability p_x,p_y,p_xy from time series:

time_series1=x(1:end);
time_series2=y(1:end);

for sym_ind1=1:length(symbols)
    for sym_ind2=1:length(symbols)
        curr_symbols_x=find(time_series1==symbols(sym_ind1));
        curr_symbols_y=find(time_series2==symbols(sym_ind2));
        curr_symbols_xy=find(time_series1==symbols(sym_ind1) & time_series2==symbols(sym_ind2));
        p_x(sym_ind1)=length(curr_symbols_x)/length(time_series1); 
        p_y(sym_ind2)=length(curr_symbols_y)/length(time_series2); 
        p_xy(sym_ind1,sym_ind2)=length(curr_symbols_xy)/length(time_series1);           %% It can also be divide by length(time_series2)
    end
end
% compute mutual information
mutual_inform=0;
for ind1=1:length(symbols)
    for ind2=1:length(symbols)
        if p_x(ind1)~=0 && p_y(ind2) ~=0 && p_xy(ind1,ind2)~=0
        mutual_inform=mutual_inform+(p_xy(ind1,ind2).*log2(p_xy(ind1,ind2)/(p_x(ind1)*p_y(ind2))));
        end
    end
end
end