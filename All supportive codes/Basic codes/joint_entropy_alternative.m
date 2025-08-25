% Compute Joint entropy H=H(x,y) of two discrete variables x and y.
% Input:
%   x and y: two integer vectors of same length
% Output:
% Joint entropy H=H(x,y)
clc
clear all
x=[1 0 1 0 1 1];
y=[0 0 1 0 1 0];
assert(numel(x)==numel(y));  % shows the error if the lengths are not same
n=numel(x);                  
x = reshape(x,1,n);          % reshape the matrix x into 1 by n form i.e., a row vector
y = reshape(y,1,n); 
l = min(min(x),min(y));      %  min(x),if x is vector then it returns the minimum value of x,and if x is matrix then it returns a row vector containing 
                             % the minimum value of each column.
x = x-l+1;
y = y-l+1;
k = max(max(x),max(y));

idx=1:n;
Mx = sparse(idx,x,1,n,k,n); 
My = sparse(idx,y,1,n,k,n); 
P = nonzeros((Mx'*My)/n);   % Joint distribution of x and y 
H = -sum(P.*log2(P))
