

function function_resample_vm_data(d,num_trail,noise_array)

for noise_ind=1:length(noise_array)

    load(['corr_data_fit/corr_noise_',num2str(noise_ind),'.mat'],'params');
    data=load(['symbols/symbols_noise_',num2str(noise_ind),'.mat'],'symbols','x_value','y_value');
     
    new_sym=cell(1,num_trail);
    new_x_val=cell(1,num_trail);
    new_y_val=cell(1,num_trail);

    
    for trail_ind=1:num_trail
       
        tic
        data1=data.symbols{trail_ind}(:,d:end);
        datax=data.x_value{trail_ind}(:,d:end);
        datay=data.y_value{trail_ind}(:,d:end);
        data1_length=size(data1,2);

        time_lag=optimal_time_delay_counting_vm(params{trail_ind}(:,1));

        tc=round(mean(time_lag));

        temp=[];tempx=[];tempy=[];
        for t=1:round(data1_length/tc)
            temp(:,t)=data1(:,(1+(t-1)*tc));
            tempx(:,t)=datax(:,(1+(t-1)*tc));
            tempy(:,t)=datay(:,(1+(t-1)*tc));
        end
        new_sym{trail_ind}=temp;
        new_x_val{trail_ind}= tempx;
        new_y_val{trail_ind}=tempy;
        toc
    end
    symbols=new_sym;
    x_value=new_x_val;
    y_value=new_y_val;
    save(['symbols_resample/symbols_noise_',num2str(noise_ind),'.mat'],'symbols','x_value','y_value','-v7.3')
    

end