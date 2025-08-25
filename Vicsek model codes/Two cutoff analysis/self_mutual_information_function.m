
function [mu_inf]=self_mutual_information_function(x,nsymbols,d)

%%% probability of x1,x %%%%

xt1=x(1+d:end);
xt=x(1:end-d);
vec_x1x = [xt1' xt'];

[tmp_x1x_1,~,tmp_x1x_3]=unique(vec_x1x,'rows');
[a,~]=size(tmp_x1x_1);
counts = histcounts(tmp_x1x_3,1:(a+1));
pr_x1x=counts./size(vec_x1x,1);

new_pr_x1x=zeros(nsymbols,nsymbols);
new_pr_x1=zeros(1,nsymbols);
new_pr_x=zeros(1,nsymbols);

if (~isempty(tmp_x1x_1))
    for ind1=1:size(tmp_x1x_1,1)
        curr_symbol=tmp_x1x_1(ind1,:);
        new_pr_x1x(curr_symbol(1),curr_symbol(2))=pr_x1x(ind1);
    end
end

%%% probabiity x %%%

for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        pr=pr+new_pr_x1x(i,j);
    end
    new_pr_x(j)=pr;
end

%%% probabiity x1 %%%

for i=1:nsymbols
    pr=0;
    for j=1:nsymbols
        pr=pr+new_pr_x1x(i,j);
    end
    new_pr_x1(i)=pr;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu_inf=0;
for i=1:nsymbols
    for j=1:nsymbols
        if(new_pr_x1x(i,j)~=0 && new_pr_x(j)~=0 &&...
                new_pr_x1(i)~=0)
            mu_inf=mu_inf+new_pr_x1x(i,j)*log2(new_pr_x1x(i,j)/(new_pr_x(j)*new_pr_x1(i)));
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%