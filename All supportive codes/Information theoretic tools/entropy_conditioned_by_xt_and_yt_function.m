%%%% Conditional entropy of y_t+1 when given y_t and x_t %%%%

function [con_ent]=entropy_conditioned_by_xt_and_yt_function(x,y,nsymbols,tau)


%%%% probability of x,x,y %%%%

x_t=x(1:end-tau);                 %%% x(t) time series
x_t_1=x(1+tau:end);               %%% x(t+1) time series
y_t=y(1:end-tau);                 %%% y(t)  time sereies

vec_x_x_y = [x_t_1' x_t' y_t'];

[tmp_x_x_y_1,~,tmp_x_x_y_3]=unique(vec_x_x_y,'rows');
[a,~]=size(tmp_x_x_y_1);
counts = histcounts(tmp_x_x_y_3,1:(a+1));
pr_x_x_y=counts./size(vec_x_x_y,1);

new_pr_x_x_y=zeros(nsymbols,nsymbols,nsymbols);
new_pr_x_x=zeros(nsymbols,nsymbols);
new_pr_x_y=zeros(nsymbols,nsymbols);
new_pr_x=zeros(1,nsymbols);
if (~isempty(tmp_x_x_y_1))
    for ind1=1:size(tmp_x_x_y_1,1)
        curr_symbol=tmp_x_x_y_1(ind1,:);
        new_pr_x_x_y(curr_symbol(1),curr_symbol(2),curr_symbol(3))=pr_x_x_y(ind1);
    end
end


%%probabiity x and y%%%
for j=1:nsymbols
    for k=1:nsymbols
        pr=0;
        for i=1:nsymbols
            pr=pr+new_pr_x_x_y(i,j,k);
        end
        new_pr_x_y(j,k)=pr;
    end
end
%%probabiity x and x%%%
for i=1:nsymbols
    for j=1:nsymbols
        pr=0;
        for k=1:nsymbols
            pr=pr+new_pr_x_x_y(i,j,k);
        end
        new_pr_x_x(i,j)=pr;
    end
end
%%Probability of x %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        for k=1:nsymbols
            pr=pr+new_pr_x_x_y(i,j,k);
        end
    end
    new_pr_x(j)=pr;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
con_ent=0;
for i=1:nsymbols
    for j=1:nsymbols
        for k=1:nsymbols
            if(new_pr_x_x_y(i,j,k)~=0 && new_pr_x_x(i,j)~=0 && ...
                    new_pr_x_y(j,k)~=0 && new_pr_x(j)~=0)
                con_ent=con_ent-new_pr_x_x_y(i,j,k)*log2(new_pr_x_x_y(i,j,k)/(new_pr_x_y(j,k)));
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
