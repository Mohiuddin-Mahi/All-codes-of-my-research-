clc
clear all
n=100;
p=linspace(0,1,n);
h=-p.*my_log2(p)-(1-p).*my_log2(1-p);
disp(h') 
plot(p,h,'linewidth',2)
xlabel('P(X)');
ylabel('H(X)');
legend('Entropy Estimation')
grid off