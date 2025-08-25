%% Mohiuddin code:
function [mutual_inform]=mutual_information_function_udoy(x,y,nsymbols,k,l)
vec_x=fliplr(sequence_prob(x,k));
vec_y = fliplr(sequence_prob(y,l));
vec_xy= [vec_x vec_y];

[tmp_xy_1,~,tmp_xy_3]=unique(vec_xy,'rows');
[a,~]=size(tmp_xy_1);
counts = histcounts(tmp_xy_3,1:(a+1));
pr_xy=counts./size(vec_xy,1);

new_pr_xy=zeros(nsymbols,nsymbols);
new_pr_x=zeros(1,nsymbols);
new_pr_y=zeros(1,nsymbols);

if (~isempty(tmp_xy_1))
    for ind1=1:size(tmp_xy_1,1)
        curr_symbol=tmp_xy_1(ind1,:);
        new_pr_xy(curr_symbol(1),curr_symbol(2))=pr_xy(ind1);
    end
end

%%probabiity x %%%
for i=1:nsymbols
    pr=0;
    for j=1:nsymbols
        pr=pr+new_pr_xy(i,j);
    end
    new_pr_x(i)=pr;
end
%%probabiity y %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        pr=pr+new_pr_xy(i,j);
    end
    new_pr_y(j)=pr;
end

% compute mutual information
mutual_inform=0;
for i=1:nsymbols
    for j=1:nsymbols
        if (new_pr_x(i)~=0 && new_pr_y(j) ~=0 && new_pr_xy(i,j)~=0)
            mutual_inform=mutual_inform+(new_pr_xy(i,j).*log2(new_pr_xy(i,j)/(new_pr_x(i)*new_pr_y(j))));
        end
    end
end
end