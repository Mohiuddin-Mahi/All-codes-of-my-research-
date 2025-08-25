

function[event_y,event_x]=adjacent_and_min_firing_grids_delete_function_new(cell_y,cell_x,indy,indx,min_firing)

data1=cell_y; data2=cell_x;
[m,n]=size(data2);

del_data={[indy-1,indx-1],[indy-1,indx],[indy-1,indx+1],[indy,indx-1],[indy,indx+1],[indy+1,indx-1],...
    [indy+1,indx],[indy+1,indx+1]};

for del_ind=1:length(del_data)

    del_grid=cell2mat(del_data(del_ind));

    if del_grid(1)>0 && del_grid(1)<=m && del_grid(2)>0 && del_grid(2)<=n

        data1{del_grid(1),del_grid(2)}=[];
        data2{del_grid(1),del_grid(2)}=[];
    end

end

event1={}; event2={};
event3={}; event4={};

for p=1:m
    for k=1:n

        if (length(find(data1{p,k}==1))>=min_firing && length(find(data2{p,k}==1))>=min_firing)
            
            if p==indy && k==indx
                event1=cat(2,event1,data1{p,k});
                event3=cat(2,event3,data2{p,k});
            else
                event2=cat(2,event2,data1{p,k});
                event4=cat(2,event4,data2{p,k});
                
            end

        end
    end
end
event_y=cat(2,event1,event2);
event_x=cat(2,event3,event4);

end
