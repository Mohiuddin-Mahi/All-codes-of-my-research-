% % clc
% % close all
% % clear;
% % 
% % tau=1;
% % symbols=2;
% % y=[1 2 2 1 1 1 2 1 2 1];
% % x=[2 2 2 1 1 1 2 1 2 2];

function [pr_x1,pr_x,pr_y, pr_xy, pr_x1x, pr_x1y,pr_x1xy] = probability_function(x,y,symbols,tau)       

pr_x=zeros(1,symbols);
pr_y=zeros(1,symbols);
pr_x1=zeros(1,symbols);
pr_xy=zeros(symbols,symbols);
pr_x1x=zeros(symbols,symbols);
pr_x1y=zeros(symbols,symbols);
pr_x1xy=zeros(symbols,symbols,symbols);

xt=x(1:end-tau);                 % x_t 
xt1=x(1+tau:end);                % x_(t+tau)
yt=y(1:end-tau);                 % y_t   


N=length(xt);

for i=1:symbols                  %%% i index for xt1     
    for j=1:symbols              %%% j index for xt
         for k=1:symbols         %%% k index for yt

             symbols_y=find(yt==k);
             symbols_x=find(xt==j);
             symbols_x1=find(xt1==i);
             
             symbols_xy=find(xt==j & yt==k);
             symbols_x1x=find(xt1==i & xt==j);
             symbols_x1y=find(xt1==i & yt==k);
             symbols_x1xy=find(xt1==i & xt==j & yt==k);

             pr_y(k)=length(symbols_y)/N;
             pr_x(j)=length(symbols_x)/N;
             pr_x1(i)=length(symbols_x1)/N;
             pr_xy(j,k)=length(symbols_xy)/N;
             pr_x1x(i,j)=length(symbols_x1x)/N; 
             pr_x1y(i,k)=length(symbols_x1y)/N;
             pr_x1xy(i,j,k)=length(symbols_x1xy)/N;
         end
    end
end

end

% % pr_x
% % pr_y
% % pr_x1
% % pr_xy
% % pr_x1x
% % pr_x1y
% % pr_x1xy
