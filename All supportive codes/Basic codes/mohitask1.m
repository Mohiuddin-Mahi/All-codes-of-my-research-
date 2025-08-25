%%Matlab code
%%Generate N random numbers within a square box of length one (1). 
%Separate those numbers by the line y=x^2 and mark the above numbers by red color.

clc
clear all
n=100;
x=linspace(0,1,n);
y=x.^2;
plot(x,y,'k-')
hold on
r=rand(n,1);
y1=rand(n,1); 
plot(r(y1>r.^2),y1(y1>r.^2),'r.',r(y1<r.^2),y1(y1<r.^2),'b.')
xlabel('x');
ylabel('y');
legend('y=x^2')
grid off
