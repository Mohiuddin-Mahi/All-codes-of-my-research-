
function [cond_ent1,cond_ent2,cond_ent3]=conditional_entropy_function_udoy(x,y,nsymbols,k,l,d)

%%%%%%%%%%%%%%%%%%%%% Probability computation %%%%%%%%%%%%%%%%%%%

vec_x=fliplr(sequence_prob(x,k));
vec_y = fliplr(sequence_prob(y,l));
vec_xx= fliplr(sequence_prob(x,d+1));
vec_x1x= [vec_xx(:,1) vec_xx(:,end)];

vec_x1xy = [vec_x1x(1:end,:) vec_y(1:end-d,:)];

[tmp_x1xy_1,~,tmp_x1xy_3]=unique(vec_x1xy,'rows');           %%% [C,ia,ic]=unique(A,'rows') i.e., C is unique matrix of A,
[a,~]=size(tmp_x1xy_1);                                      %%%% ia is index of C's rows in A, ic is index of A's rows in C.
counts = histcounts(tmp_x1xy_3,1:(a+1));
pr_x1xy=counts./size(vec_x1xy,1);

new_pr_x1xy=zeros(nsymbols,nsymbols,nsymbols);
new_pr_x1x=zeros(nsymbols,nsymbols);
new_pr_x1y=zeros(nsymbols,nsymbols);
new_pr_xy=zeros(nsymbols,nsymbols);
new_pr_x=zeros(nsymbols);
new_pr_y=zeros(nsymbols);

if (~isempty(tmp_x1xy_1))
    for ind1=1:size(tmp_x1xy_1,1)
        curr_symbol=tmp_x1xy_1(ind1,:);
        new_pr_x1xy(curr_symbol(1),curr_symbol(2),curr_symbol(3))=pr_x1xy(ind1);
    end
end

%% Probability of x1 and x %%%
for i=1:nsymbols
    for j=1:nsymbols
        pr=0;
        for k=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
        new_pr_x1x(i,j)=pr;
    end
end

%% Probability of x1 and y %%%
for i=1:nsymbols
    for k=1:nsymbols
        pr=0;
        for j=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
        new_pr_x1y(i,k)=pr;
    end
end

%% Probability of x and y %%%
for j=1:nsymbols
    for k=1:nsymbols
        pr=0;
        for i=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
        new_pr_xy(j,k)=pr;
    end
end

%% Probability of x %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        for k=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
    end
    new_pr_x(j)=pr;
end

%% Probability of y %%%
for k=1:nsymbols
    pr=0;
    for i=1:nsymbols
        for j=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
    end
    new_pr_y(k)=pr;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Conditional entropy computation conditioned by x_t %%%%
cond_ent1=0;
for i=1:nsymbols
    for j=1:nsymbols
        if(new_pr_x1x(i,j)~=0 && new_pr_x(j)~=0)
            cond_ent1=cond_ent1-(new_pr_x1x(i,j)*log2(new_pr_x1x(i,j)/new_pr_x(j)));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% Conditional entropy computation conditioned by x_t & y_t %%%
cond_ent2=0;
for i=1:nsymbols
    for j=1:nsymbols
        for k=1:nsymbols
            if(new_pr_x1xy(i,j,k)~=0 && new_pr_xy(j,k)~=0)
                cond_ent2=cond_ent2-(new_pr_x1xy(i,j,k)*log2(new_pr_x1xy(i,j,k)/new_pr_xy(j,k)));
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Conditional entropy computation conditioned by y_t %%%%
cond_ent3=0;
for i=1:nsymbols
    for k=1:nsymbols
        if(new_pr_x1y(i,k)~=0 && new_pr_y(k)~=0)
            cond_ent3=cond_ent3-(new_pr_x1y(i,k)*log2(new_pr_x1y(i,k)/new_pr_y(k)));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
