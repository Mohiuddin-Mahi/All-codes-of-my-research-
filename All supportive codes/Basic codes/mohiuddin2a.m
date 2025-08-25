clc
clear all
%n=[10 100 1000 10000];
n=logspace(1,4,4);
for i=1:length(n)
    tic
x=linspace(0,1,n(i));
y=x.^2;
y1=x;
r=rand(n(i),1);
y2=rand(n(i),1);
count=0;
temp=0;
for j=1:n(i)
    if y2(j)<r(j).^2
        count=count+1;
    else
        temp=temp+1;
    end
end
    count_n(i)=count;
    temp_n(i)=temp;
    fprintf('The number of points underneath the line is:%d\n',count_n(i))
    elapsed_time(i)=toc
end
tiledlayout(3,1)
nexttile
plot(x,y,'k*',x,y1,'g*')
hold on
plot(r(y2>r.^2),y2(y2>r.^2),'r.',r(y2<r.^2),y2(y2<r.^2),'b.')
xlabel('x');
ylabel('y');
legend('y=x^2','y=x')
title('Figure-1')
hold off
nexttile
Aprime=count_n./n;
Aactual=1/2;
loglog(n,abs((Aprime-Aactual)/Aactual),'-ro')
xlabel('n');
ylabel('Num_points/n');
title('Figure-2')
nexttile
semilogx(n,elapsed_time,'-ko')
xlabel('n');
ylabel('elapsed_time');
title('Figure-3')
grid off
