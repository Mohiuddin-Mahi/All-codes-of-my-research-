
function [cond_entropy_x,cond_entropy_y,new_pr_x_y]=cond_entropy_function_udoy(x,y,nsymbols)


%%%% probability of x,x,y %%%%
x_t=x(1:end);                 %%% x(t) time series
y_t=y(1:end);                 %%% y(t)  time sereies

vec_x_y = [x_t' y_t'];

[tmp_x_y_1,~,tmp_x_y_3]=unique(vec_x_y,'rows');
[a,~]=size(tmp_x_y_1);
counts = histcounts(tmp_x_y_3,1:(a+1));
pr_x_y=counts./size(vec_x_y,1);

new_pr_x_y=zeros(nsymbols,nsymbols);
new_pr_x=zeros(1,nsymbols);
new_pr_y=zeros(1,nsymbols);
if (~isempty(tmp_x_y_1))
    for ind1=1:size(tmp_x_y_1,1)
        curr_symbol=tmp_x_y_1(ind1,:);
        new_pr_x_y(curr_symbol(1),curr_symbol(2))=pr_x_y(ind1);
    end
end

%%probabiity x %%%
for i=1:nsymbols
    pr=0;
    for j=1:nsymbols
        pr=pr+new_pr_x_y(i,j);
    end
    new_pr_x(i)=pr;
end
%%probabiity y %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        pr=pr+new_pr_x_y(i,j);
    end
    new_pr_y(j)=pr;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cond_entropy_x=0;
for i=1:nsymbols
    for j=1:nsymbols
        if(new_pr_x_y(i,j)~=0 && new_pr_x(i)~=0)
            cond_entropy_x=cond_entropy_x-new_pr_x_y(i,j)*log2(new_pr_x_y(i,j)/new_pr_x(i));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cond_entropy_y=0;
for i=1:nsymbols
    for j=1:nsymbols
        if(new_pr_x_y(i,j)~=0 && new_pr_y(j)~=0)
            cond_entropy_y=cond_entropy_y-new_pr_x_y(i,j)*log2(new_pr_x_y(i,j)/new_pr_y(j));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
