

function[typical_lags]=optimal_time_delay_counting_vm(gamma)

typical_lags=zeros(size(gamma));

for ind=1:size(gamma,1)
    a=1/gamma(ind);
    if a<0.5
        typical_lags(ind,1)=ceil(a);
    else
        typical_lags(ind,1)=round(a);
    end

end
