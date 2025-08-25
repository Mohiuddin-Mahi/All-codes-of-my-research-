
function mu_inf=calc_mutual_information(pr_x_y,nsymbols)

new_pr_x_y=zeros(nsymbols,nsymbols);
new_pr_x=zeros(1,nsymbols);
new_pr_y=zeros(1,nsymbols);
tmp_x_y_1=[1 1; 1 2; 2 1; 2 2];

for ind1=1:size(tmp_x_y_1,1)
    curr_symbol=tmp_x_y_1(ind1,:);
    new_pr_x_y(curr_symbol(1),curr_symbol(2))=pr_x_y(ind1);
end

%%probabiity x %%%
for i=1:nsymbols
    pr=0;
    for j=1:nsymbols
        pr=pr+new_pr_x_y(i,j);
    end
    new_pr_x(i)=pr;
end
%%Probability of y %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        pr=pr+new_pr_x_y(i,j);
    end
    new_pr_y(j)=pr;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu_inf=0;
for i=1:nsymbols
    for j=1:nsymbols
        if(new_pr_x_y(i,j)~=0 & new_pr_x(i)~=0 & new_pr_y(j)~=0)
            mu_inf=mu_inf+new_pr_x_y(i,j)*log2(new_pr_x_y(i,j)/...
                (new_pr_x(i)*new_pr_y(j)));
        end
    end
end
end