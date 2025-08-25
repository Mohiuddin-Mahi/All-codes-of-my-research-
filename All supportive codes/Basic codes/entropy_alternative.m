% Compute entropy H(x) of a discrete variable x.
% Input:
%   x: a integer vectors  
% Output:
% entropy H(x)
clc
clear all
x=[1 0 1 0 1 1];
n=numel(x);           % number of element of x
[u,~,x1] = unique(x); % u returns a row vector of unique elements of x and x1 indicates the indices of the elements of x in u.
k = numel(u);         % number of element of u
idx=1:n;
Mx = sparse(idx,x1,1,n,k,n); % Here (idx,x1) rows and column indices(they must have same data in x and u), '1' is the nonzero element of u,n is rows 
                             % dimension, k is columns dimension and the last n is size of x
Px = nonzeros(mean(Mx,1));   % https://www.geeksforgeeks.org/mean-function-in-matlab. Here mean(Mx,1) defines the mean of each column of Mx
                             % i.e., division of each column by total number of rows
Hx = -sum(Px.*log2(Px))
