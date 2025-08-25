
function [tdmi_y_x]=tdmi_function_udoy(x,y,nsymbols,k,l,d)

%probability of x,x,y%%
vec_x=fliplr(sequence_prob(x,k));
vec_y = fliplr(sequence_prob(y,l));
vec_xx= fliplr(sequence_prob(x,d+1));

vec_x1y = [vec_xx(:,1) vec_y(1:end-d,:)];

[tmp_x1y_1,~,tmp_x1y_3]=unique(vec_x1y,'rows');
[a,~]=size(tmp_x1y_1);
counts = histcounts(tmp_x1y_3,1:(a+1));
pr_x1y=counts./size(vec_x1y,1);

new_pr_x1y=zeros(nsymbols,nsymbols);
new_pr_x1=zeros(1,nsymbols);
new_pr_y=zeros(1,nsymbols);
if (~isempty(tmp_x1y_1))
    for ind1=1:size(tmp_x1y_1,1)
        curr_symbol=tmp_x1y_1(ind1,:);
        new_pr_x1y(curr_symbol(1),curr_symbol(2))=pr_x1y(ind1);
    end
end
%%probabiity x1 %%%
for i=1:nsymbols
    pr=0;
    for j=1:nsymbols
        pr=pr+new_pr_x1y(i,j);
    end
    new_pr_x1(i)=pr;
end
%%probabiity y %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        pr=pr+new_pr_x1y(i,j);
    end
    new_pr_y(j)=pr;
end

% compute mutual information
tdmi_y_x=0;
for i=1:nsymbols
    for j=1:nsymbols
        if (new_pr_x1(i)~=0 && new_pr_y(j) ~=0 && new_pr_x1y(i,j)~=0)
            tdmi_y_x=tdmi_y_x+(new_pr_x1y(i,j).*log2(new_pr_x1y(i,j)/(new_pr_x1(i)*new_pr_y(j))));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end