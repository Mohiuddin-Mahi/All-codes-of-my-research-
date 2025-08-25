% % clc
% % close all
% % clear;
% % tau=1;
% % nsymbols=2;
% % y=[1 2 2 1 1 1 2 1 2 1];
% % x=[2 2 2 1 1 1 2 1 2 2];


function [pr_x1,pr_x,pr_y,pr_x1x,pr_x1y,pr_xy,new_pr_x1xy]=probability_distribution_function(x,y,nsymbols,tau)

xt=x(1:end-tau);
xt1=x(1+tau:end);
yt=y(1:end-tau);

vec_x1xy=[xt1' xt' yt'];                         %% 1st col.x_(t+tau),2nd col.x_t &3rd col. y_t of vec_x_x_y 

%Probability of x_(t+tau),x_t,y_t%%

[tmp_x1xy_1,~,tmp_x1xy_3]=unique(vec_x1xy,'rows');      % [c,ia,ic]=unique(A,'rows') see in online. Here c is tmp_x_x_y_1, ic is tmp_x_x_y_3 and ia is ~. 
                                                        % Since  ia is not required/necessary.    
[a,~]=size(tmp_x1xy_1);                                 % [a,b] is written as [a,~] since b is not necessary here.
counts = histcounts(tmp_x1xy_3,1:(a+1));                % N = histcounts(X,nbins), it partitions the values of X 
                                                        % into n bins and each bin contains the similar elements 
                                                        % and gives us the number of elements of each bin.
pr_x1xy=counts./size(vec_x1xy,1);

new_pr_x1xy=zeros(nsymbols,nsymbols,nsymbols);
pr_x1x=zeros(nsymbols,nsymbols);
pr_x1y=zeros(nsymbols,nsymbols);
pr_xy=zeros(nsymbols,nsymbols);
pr_x1=zeros(1,nsymbols);
pr_x=zeros(1,nsymbols);
pr_y=zeros(1,nsymbols);

if (~isempty(tmp_x1xy_1))
    for ind1=1:size(tmp_x1xy_1,1)
        curr_symbol=tmp_x1xy_1(ind1,:);
        new_pr_x1xy(curr_symbol(1),curr_symbol(2),curr_symbol(3))=pr_x1xy(ind1); 
    end
end

%%probabiity x_(t+tau) and x_t%%%
for i=1:nsymbols              %% i index for x_(t+tau)    
    for j=1:nsymbols          %% j index for xt   
        pr=0;
        for k=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
        pr_x1x(i,j)=pr;
    end
end

%%probabiity x_(t+tau) and y_t%%%
for i=1:nsymbols              %% i index for x_(t+tau)    
    for k=1:nsymbols          %% k index for yt   
        pr=0;
        for j=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
        pr_x1y(i,k)=pr;
    end
end

%%probabiity x_t and y_t%%%
for j=1:nsymbols              %% j index for x_t
    for k=1:nsymbols          %% k index for y_t
        pr=0;
        for i=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
        pr_xy(j,k)=pr;
    end
end
%%Probability of x_(t+tau) %%%
for i=1:nsymbols
    pr=0;
    for j=1:nsymbols
        for k=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
    end
    pr_x1(i)=pr;
end
%%Probability of x_t %%%
for j=1:nsymbols
    pr=0;
    for i=1:nsymbols
        for k=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
    end
    pr_x(j)=pr;
end
%%Probability of y_t %%%
for k=1:nsymbols
    pr=0;
    for i=1:nsymbols
        for j=1:nsymbols
            pr=pr+new_pr_x1xy(i,j,k);
        end
    end
    pr_y(k)=pr;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % end
% % pr_x1
% % pr_x
% % pr_y
% % pr_x1x
% % pr_x1y
% % pr_xy
% % new_pr_x1xy


