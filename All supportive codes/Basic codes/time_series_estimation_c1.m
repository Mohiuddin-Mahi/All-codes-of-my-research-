% *Synergistic Time series estimation.* 
% Compute time series x_t and y_t. Where x_t is a random variable/process (random coin toss) such as x_t=0 with probability c and x_t=1 with probability 1-c.
% The future value of y_t depends on the past values of x_t and y_t such that
% y_(t+1)=x_t XOR y_t where y(0)=y(1)=0.

%%Incomplete code%%

clc
clear all
n=10;
r=rand(n,1);
c=0.4;
y(1)=0;

x(r<c)=0;
x(r>=c)=1;
y=zeros(1,n);
y(2:n)=xor(x(1:n-1),y(1:n-1));

symbols(:,1)=uint8(x);
symbols(:,2)=uint8(y)

%fprintf('x_t=%d\n')
%disp(x)
%fprintf('y_t=%d\n')
%disp(y)