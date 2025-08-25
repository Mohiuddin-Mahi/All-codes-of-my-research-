
% *Intrinsic Time series Estimation.* 
% Compute time series x_t and y_t. Where x_t is a random variable/process (random coin toss) such as x_t=0 with probability c and x_t=1 with probability 1-c.
% The future value of y_t depends on the past values of x_t such that
% y_(t+1)=x_t  where y(0)=y(1)=1.
clc
clear all
n=10;
r=rand(n,1);
c=0.6;
y(1)=1;
for t=1:n
    if r(t)<c
        x(t)=0;
    else
        x(t)=1;
    end
    if t<n
        y(t+1)=x(t);
    end
end

symbols(:,1)=uint8(x);
symbols(:,2)=uint8(y)


%fprintf('x_t=%d\n')
%disp(x)
%fprintf('y_t=%d\n')
%disp(y)





