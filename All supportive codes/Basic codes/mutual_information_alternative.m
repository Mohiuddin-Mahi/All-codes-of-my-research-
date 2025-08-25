% Compute mutual information I=I(x;y) of two discrete variables x and y.
% Input:
%   x, y: two integer vector of the same length 
% Output:
%  mutual information I=I(x;y)

clc
clear all
x=[1 0 1 0 1 1];
y=[0 0 1 0 1 0];

assert(numel(x) == numel(y));
n = numel(x);

x = reshape(x,1,n);
y = reshape(y,1,n);

l = min(min(x),min(y));
x = x-l+1;
y = y-l+1;
k = max(max(x),max(y));

idx = 1:n;
Mx = sparse(idx,x,1,n,k,n);
My = sparse(idx,y,1,n,k,n);

Px = nonzeros(mean(Mx,1));          %marginal distribution of x
Py = nonzeros(mean(My,1));          %marginal distribution of y
Pxy = nonzeros((Mx'*My)/n);         %joint distribution of x and y

Hx = -dot(Px,log2(Px));             %entropy of x
Hy = -dot(Py,log2(Py));             %entropy of x
Hxy = -dot(Pxy,log2(Pxy));          %joint entropy of x and y

% mutual information I=I(x;y)
I = Hx+Hy-Hxy