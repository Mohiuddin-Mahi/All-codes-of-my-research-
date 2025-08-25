

% % clc
% % close all
% % clear;
% % 
% % x=[1 2 3; 4 5 6;7 8 9];
% % cell_x=mat2cell(x,[1 1 1],[1 1 1])
% % indy=3;
% % indx=3;

function[event]=adjacent_grids_delete_function(cell_x,indy,indx)

data=cell_x;
[m,n]=size(data);

del_data={[indy-1,indx-1],[indy-1,indx],[indy-1,indx+1],[indy,indx-1],[indy,indx+1],[indy+1,indx-1],...
    [indy+1,indx],[indy+1,indx+1]};

for del_ind=1:length(del_data)

    del_grid=cell2mat(del_data(del_ind));

    if del_grid(1)>0 && del_grid(1)<=m && del_grid(2)>0 && del_grid(2)<=n

        data{del_grid(1),del_grid(2)}=[];
    end

end
new_data=data;

event1={};
event2={};

for p=1:m
    for k=1:n

        a=new_data{p,k};

        if ~isempty(a)
            if p==indy && k==indx
                event1=cat(2,event1,a);
            else
                event2=cat(2,event2,a);
                
            end

        end
    end
end
event=cat(2,event1,event2);

end
