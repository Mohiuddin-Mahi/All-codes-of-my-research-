
function [im_data,firing_data_with_location]=location_of_firing_function(resize_param,data_t,data_t1)

ind1=1;

firing_data_with_location=[];

data1=imresize(double(data_t),resize_param)>0;
data2=imresize(double(data_t1),resize_param)>0;


im_data=zeros(size(data1,1),size(data1,2));

for i=1:size(data1,1)
    for j=1:size(data1,2)

        if(data1(i,j)==0 && data2(i,j)==0)
            im_data(i,j)=1;        %%% 00      
        elseif(data1(i,j)==0 && data2(i,j)==1)
            im_data(i,j)=2;        %%% 01
        elseif(data1(i,j)==1 && data2(i,j)==0)
            im_data(i,j)=3;        %%% 10
        else
            im_data(i,j)=4;        %%% 11
        end
        if(data1(i,j)>0)
            firing_data_with_location(ind1,:)=[i j];
            ind1=ind1+1;
        end

    end
end

end
