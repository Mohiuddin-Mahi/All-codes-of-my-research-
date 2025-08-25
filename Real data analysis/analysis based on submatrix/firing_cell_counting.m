
function[firing_y,firing_x]=firing_cell_counting(cell_y,cell_x)

[m,n]=size(cell_y);
firing_y=zeros(m,n);
firing_x=zeros(m,n);

for i=1:m

    for j=1:n
    firing_y(i,j)=length(find(cell_y{i,j}==1));
    firing_x(i,j)=length(find(cell_x{i,j}==1));
    end
    
end
