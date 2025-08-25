
%%Mohiuddin code: Compute transfer entropy
function [TE_x_y] = transfer_ent_function_mohi(x,y,tau,symbols)

pr_y=zeros(length(symbols));
pr_zy=zeros(length(symbols),length(symbols));
pr_yx=zeros(length(symbols),length(symbols));
pr_zyx=zeros(length(symbols),length(symbols),length(symbols)); % For running the pc more faster.

%% Compute probability p_x,p_y,p_z,p_xy,p_xz,p_zy,p_zyx from time series:

time_series1=x(1:end-tau);                       %% time_series= x_t, time_series2=y_t and time_series3=y_(t+1)=z
time_series2=y(1:end-tau);          
time_series3=y(tau+1:end);

N=length(time_series1);
for sym_ind3=1:length(symbols)                                     %% We also can write the loops of ind1 first and loop of ind3 last, that also give the same answer.
    for sym_ind2=1:length(symbols)
         for sym_ind1=1:length(symbols)
             
             curr_symbols_y=find(time_series2==symbols(sym_ind2));
             curr_symbols_yx=find(time_series2==symbols(sym_ind2) & time_series1==symbols(sym_ind1)); 
             curr_symbols_zy=find(time_series3==symbols(sym_ind3) & time_series2==symbols(sym_ind2));
             curr_symbols_zyx=find(time_series3==symbols(sym_ind3) & time_series2==symbols(sym_ind2)& time_series1==symbols(sym_ind1));

             
             pr_y(sym_ind2)=length(curr_symbols_y)/N;
             pr_yx(sym_ind2,sym_ind1)=length(curr_symbols_yx)/N;
             pr_zy(sym_ind3,sym_ind2)=length(curr_symbols_zy)/N;
             pr_zyx(sym_ind3,sym_ind2,sym_ind1)=length(curr_symbols_zyx)/N;
   
         end
    end
end


%% Compute transfer entropy TE_x_y from the probabilities of time series:
TE_x_y=0;
for ind3=1:length(symbols)                                                     %% We also can write the loops of ind1 first and loop of ind3 last, that also give the same answer.
    for ind2=1:length(symbols)
        for ind1=1:length(symbols)
            if  pr_y(ind2)~=0 && pr_yx(ind2,ind1)~=0  && pr_zy(ind3,ind2)~=0 && pr_zyx(ind3,ind2,ind1)~=0
                TE_x_y=TE_x_y+(pr_zyx(ind3,ind2,ind1)*log2((pr_zyx(ind3,ind2,ind1)*pr_y(ind2))/(pr_yx(ind2,ind1).*pr_zy(ind3,ind2))));
            end
        end
    end
end
