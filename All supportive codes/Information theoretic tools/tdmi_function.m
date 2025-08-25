%% Mohiuddin code:

function [TDMI_x_y] = tdmi_function(x,y,tau,symbols)
pr_x=zeros(length(symbols));
pr_z=zeros(length(symbols));
pr_xz=zeros(length(symbols),length(symbols));     % For making the pc more faster.

%% Compute probability p_x,p_y,p_z,p_xy,p_xz,p_zy from time series:

time_series1=x(1:end-tau);              %% time_series= x_t, time_series2=y_t and time_series3=y_(t+1)=z
time_series2=y(1:end-tau);          
time_series3=y(1+tau:end);

N=length(time_series1);
for sym_ind1=1:length(symbols)                                     
    for sym_ind2=1:length(symbols)
             curr_symbols_x=find(time_series1==symbols(sym_ind1));
             curr_symbols_z=find(time_series3==symbols(sym_ind2));
             curr_symbols_xz=find(time_series1==symbols(sym_ind1) & time_series3==symbols(sym_ind2));
             pr_x(sym_ind1)=length(curr_symbols_x)/N;
             pr_z(sym_ind2)=length(curr_symbols_z)/N;
             pr_xz(sym_ind1,sym_ind2)=length(curr_symbols_xz)/N; 
    end
end


%% Compute time delayed mutual information TDMI_x_y from the probabilities of time series:
TDMI_x_y=0;
for ind1=1:length(symbols)
    for ind2=1:length(symbols)
        if  pr_x(ind1) ~=0 && pr_z(ind2)~=0  && pr_xz(ind1,ind2)~=0
            TDMI_x_y=TDMI_x_y+(pr_xz(ind1,ind2).*log2(pr_xz(ind1,ind2)/(pr_x(ind1).*pr_z(ind2))));
        end
    end
end
