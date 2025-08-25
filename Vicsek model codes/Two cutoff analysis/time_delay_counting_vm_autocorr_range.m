

function[optimal_lags,all_lags]=time_delay_counting_vm_autocorr_range(data,corr_threshold)

optimal_lags=zeros(size(data,1),1);
all_lags=cell(size(data,1),1);

for ind=1:size(data,1)
    lags=find(data(ind,:)>=0 & data(ind,:)<=corr_threshold);
    optimal_lags(ind,1)=min(lags);
    all_lags{ind}=lags;
end
