
function [cond_ent1,cond_ent2,cond_ent3,cond_ent4]=causation_conditional_entropy_function(x,y,z,tau,nsymbols)

%%%%%%%%%%%%%%%%%%%%% Probability computation %%%%%%%%%%%%%%%%%%%

x_t=x(1:end-tau);                 %%% x_t=x time series
x_t_1=x(1+tau:end);               %%% x_(t+1)=x1 time series
y_t=y(1:end-tau);                 %%% y_t=y  time sereies
z_t=z(1:end-tau);                 %%% z_t=z  time sereies

vec_x1xyz = [x_t_1' x_t' y_t' z_t'];

[tmp_x1xyz_1,~,tmp_x1xyz_3]=unique(vec_x1xyz,'rows');           %%% [C,ia,ic]=unique(A,'rows') i.e., C is unique matrix of A,
[a,~]=size(tmp_x1xyz_1);                                        %%%% ia is index of C's rows in A, ic is index of A's rows in C.
counts = histcounts(tmp_x1xyz_3,1:(a+1));
pr_x1xyz=counts./size(vec_x1xyz,1);

new_pr_x1xyz=zeros(nsymbols,nsymbols,nsymbols,nsymbols);
new_pr_x1xy=zeros(nsymbols,nsymbols,nsymbols);
new_pr_x1xz=zeros(nsymbols,nsymbols,nsymbols);
new_pr_xyz=zeros(nsymbols,nsymbols,nsymbols);
new_pr_xy=zeros(nsymbols,nsymbols);
new_pr_xz=zeros(nsymbols,nsymbols);
new_pr_x1x=zeros(nsymbols,nsymbols);
new_pr_x=zeros(1,nsymbols);

if (~isempty(tmp_x1xyz_1))
    for ind1=1:size(tmp_x1xyz_1,1)
        curr_symbol=tmp_x1xyz_1(ind1,:);
        new_pr_x1xyz(curr_symbol(1),curr_symbol(2),curr_symbol(3),curr_symbol(4))=pr_x1xyz(ind1);
    end
end

%%% probabiity x,y and z %%%                 %%%% ind i for x1, j for x, k for y and l for z %%%
for j=1:nsymbols
    for k=1:nsymbols
        for l=1:nsymbols
            pr=0;
            for i=1:nsymbols
                pr=pr+new_pr_x1xyz(i,j,k,l);
            end
            new_pr_xyz(j,k,l)=pr;
        end
    end
end

%%% probabiity x1, x and y %%%
for i=1:nsymbols
    for j=1:nsymbols
        for k=1:nsymbols
            pr=0;
            for l=1:nsymbols
                pr=pr+new_pr_x1xyz(i,j,k,l);
            end
            new_pr_x1xy(i,j,k)=pr;
        end
    end
end

%% probabiity x1, x and z %%%
for i=1:nsymbols
    for j=1:nsymbols
        for l=1:nsymbols
            pr=0;
            for k=1:nsymbols
                pr=pr+new_pr_x1xyz(i,j,k,l);
            end
            new_pr_x1xz(i,j,l)=pr;
        end
    end
end

%%% Probability of x and y %%%
for j=1:nsymbols
    for k=1:nsymbols
        pr=0;
        for i=1:nsymbols
            for l=1:nsymbols
                pr=pr+new_pr_x1xyz(i,j,k,l);
            end
        end
        new_pr_xy(j,k)=pr;
    end
end

%%% Probability of x and z %%%
for j=1:nsymbols
    for l=1:nsymbols
        pr=0;
        for i=1:nsymbols
            for k=1:nsymbols
                pr=pr+new_pr_x1xyz(i,j,k,l);
            end
        end
        new_pr_xz(j,l)=pr;
    end
end

%% Probability of x1 and x %%%
for i=1:nsymbols
    for j=1:nsymbols
        pr=0;
        for k=1:nsymbols
            for l=1:nsymbols
                pr=pr+new_pr_x1xyz(i,j,k,l);
            end
        end
        new_pr_x1x(i,j)=pr;
    end
end

%%Probability of x %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        for k=1:nsymbols
            for l=1:nsymbols
                pr=pr+new_pr_x1xyz(i,j,k,l);
            end
        end
    end
    new_pr_x(j)=pr;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Conditional entropy computation conditioned by x_t %%%%%%%%%%%%%%%%%%%%%%%%%%
cond_ent1=0;
for i=1:nsymbols
    for j=1:nsymbols
        if(new_pr_x1x(i,j)~=0 && new_pr_x(j)~=0)
            cond_ent1=cond_ent1-(new_pr_x1x(i,j)*log2(new_pr_x1x(i,j)/new_pr_x(j)));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Conditional entropy computation conditioned by x_t & z_t %%%%%%%%%%%%%%%%%%%%%%%%%%
cond_ent2=0;
for i=1:nsymbols
    for j=1:nsymbols
        for l=1:nsymbols
            if(new_pr_x1xz(i,j,l)~=0 && new_pr_xz(j,l)~=0)
                cond_ent2=cond_ent2-(new_pr_x1xz(i,j,l)*log2(new_pr_x1xz(i,j,l)/new_pr_xz(j,l)));
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Conditional entropy computation conditioned by x_t & y_t %%%%%%%%%%%%%%%%%%%%%%%%%%
cond_ent3=0;
for i=1:nsymbols
    for j=1:nsymbols
        for k=1:nsymbols
            if(new_pr_x1xy(i,j,k)~=0 && new_pr_xy(j,k)~=0)
                cond_ent3=cond_ent3-(new_pr_x1xy(i,j,k)*log2(new_pr_x1xy(i,j,k)/new_pr_xy(j,k)));
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Conditional entropy computation conditioned by x_t,y_t & z_t %%%%%%%%%%%%%%%%%%%%%%%%%%
cond_ent4=0;
for i=1:nsymbols
    for j=1:nsymbols
        for k=1:nsymbols
            for l=1:nsymbols
                if(new_pr_x1xyz(i,j,k,l)~=0 && new_pr_xyz(j,k,l)~=0)
                    cond_ent4=cond_ent4-(new_pr_x1xyz(i,j,k,l)*log2(new_pr_x1xyz(i,j,k,l)/new_pr_xyz(j,k,l)));
                end
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
