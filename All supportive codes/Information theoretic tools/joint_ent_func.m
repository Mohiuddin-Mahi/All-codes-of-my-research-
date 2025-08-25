%%Mohiuddin code:Compute joint entropy

function [joint_ent]=joint_ent_func(x,y,symbols)
p_x=zeros(length(symbols));        %% For large data pc may be slow so this statement is used to make the pc faster
p_y=zeros(length(symbols));
p_xy=zeros(length(symbols),length(symbols));

%% Compute probability p_xy from time series:
time_series1=x(1:end);
time_series2=y(1:end);

for sym_ind1=1:length(symbols)
    for sym_ind2=1:length(symbols)
        curr_symbols_x=find(time_series1==symbols(sym_ind1));
        curr_symbols_y=find(time_series2==symbols(sym_ind2));
        curr_symbols_xy=find(time_series1==symbols(sym_ind1) & time_series2==symbols(sym_ind2));
        p_x(sym_ind1)=length(curr_symbols_x)/length(time_series1); 
        p_y(sym_ind2)=length(curr_symbols_y)/length(time_series2); 
        p_xy(sym_ind1,sym_ind2)=length(curr_symbols_xy)/length(time_series1); 
    end
end


% compute joint entropy:
joint_ent=0;
for ind1=1:length(symbols)
    for ind2=1:length(symbols)
        if p_xy(ind1,ind2)~=0
        joint_ent=joint_ent-(p_xy(ind1,ind2).*log2(p_xy(ind1,ind2)));
        end
    end
end
end
