% *Shared Time Series Estimation.* 
% Compute time series x_t and y_t. Where x_t is a random variable/process (random coin toss) such as x_t=0 with probability c and x_t=1 with probability 1-c.
% The future value of y_t depends on the past values of x_t and y_t individually such that
% y_(t+1)=~x_t=~y_t where y(0)=y(1)=1.

clc
clear all
n=10;
x(1)=0;

for t=2:n
   x(t)=~x(t-1);
   y(t)=x(t);
end

symbols(:,1)=uint8(x);
symbols(:,2)=uint8(y)

%fprintf('x_t=%d\n')
%disp(x)
%fprintf('y_t=%d\n')
%disp(y)