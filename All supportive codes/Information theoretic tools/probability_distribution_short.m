
clc
clear all
k=1;l=1;m=1;d=3;
nsymbols=6;
load('symbols_logistic_type_1_cpoint_10.mat')
x=symbols{1}(3,:);
y=symbols{1}(2,:);
z=symbols{1}(1,:);

vec_x = fliplr(sequence_prob(x,k));
vec_y = fliplr(sequence_prob(y,l));
vec_z=fliplr(sequence_prob(z,m));
vec_x_x = fliplr(sequence_prob(x,d+1));
vec_x_x_1= [vec_x_x(:,1) vec_x_x(:,end)];

vec_x_x_y_z = [vec_x_x_1(1:end,:) vec_y(1:end-d,:) vec_z(1:end-d,:)];

[tmp_x_x_y_z_1,tmp_x_x_y_z_2,tmp_x_x_y_z_3]=unique(vec_x_x_y_z,'rows');
[a,b]=size(tmp_x_x_y_z_1);
counts = histcounts(tmp_x_x_y_z_3,1:(a+1));
pr_x_x_y_z=counts./size(vec_x_x_y_z,1);

new_pr_x_x_y_z=zeros(nsymbols,nsymbols,nsymbols,nsymbols);
new_pr_x_x_y=zeros(nsymbols,nsymbols,nsymbols);
new_pr_x_y_z=zeros(nsymbols,nsymbols,nsymbols);
new_pr_x_y=zeros(nsymbols,nsymbols);

if (~isempty(tmp_x_x_y_z_1))
    for ind1=1:size(tmp_x_x_y_z_1,1)
        curr_symbol=tmp_x_x_y_z_1(ind1,:);
        new_pr_x_x_y_z(curr_symbol(1),curr_symbol(2),curr_symbol(3),curr_symbol(4))=pr_x_x_y_z(ind1);
    end
end

%%% probabiity x,y and z %%%                 %%%% ind i for x1, j for x, k for y and l for z %%%
for j=1:nsymbols
    for k=1:nsymbols
        for l=1:nsymbols
            pr=0;
            for i=1:nsymbols
                pr=pr+new_pr_x_x_y_z(i,j,k,l);
            end
                new_pr_x_y_z(j,k,l)=pr;
        end
    end
end

%%% probabiity x, x and y %%%
for i=1:nsymbols
    for j=1:nsymbols
        for k=1:nsymbols
            pr=0;
            for l=1:nsymbols
                pr=pr+new_pr_x_x_y_z(i,j,k,l);
            end
                new_pr_x_x_y(i,j,k)=pr;
        end
    end
end

%%% Probability of x and y %%%
for j=1:nsymbols
    for k=1:nsymbols
        pr=0;
        for i=1:nsymbols
            for l=1:nsymbols
                pr=pr+ne