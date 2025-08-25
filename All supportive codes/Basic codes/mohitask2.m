                                                                 %Let consider some N_array=[10 100 1000 10000] within a square box of length one (1). 
%n=[10 100 1000 10000 100000 1000000 1000000];                              %Then for each N, count how many points lie under,above and between the lines y=x^2 and y=x,
n=logspace(1,7,7);          % same as n=[10 100 1000 10000]                 %Count elapsed time vs N, Relative error vs N.Plot the figures for each cases.
for i=1:length(n)
    tic
x=linspace(0,1,n(i));
y=x.^2;
y1=x;
r=rand(n(i),1);
y2=rand(n(i),1);
count=0;
temp=0;
temp_1=0;
for j=1:n(i)
    if y2(j)<r(j) && y2(j)>r(j)^2
        count=count+1;
    elseif y2(j)<r(j)^2
        temp_1=temp_1+1;
    else
        temp=temp+1;
    end
end
    count_n(i)=count;
    temp_a(i)=temp_1;
    temp_n(i)=temp;
    fprintf('The number of points underneath the line y=x^2 is:%d\n',count_n(i))
    fprintf('The number of points between the lines y=x and y=x^2 is:%d\n',temp_a(i))
    fprintf('The number of points above the line y=x is:%d\n',temp_n(i))
    elapsed_time(i)=toc
end
tiledlayout(3,1)
nexttile
plot(x,y,'k*',x,y1,'g*',r(y2>r.^2),y2(y2>r.^2),'r.',r(y2<r.^2),y2(y2<r.^2),'b.',r(y2<r & y2>r.^2),y2(y2<r & y2>r.^2),'y.')
xlabel('x');
ylabel('y');
legend('y=x^2','y=x')
title('Figure-1')
nexttile
Aprime=count_n./n;      % probability defined by division of each element of count_n by total number n.
Aprime_1=temp_a./n;
Aprime_2=temp_n./n;
Aactual=1/3;           % actual probability
Aactual_1=1/6;         % actual probability
Aactual_2=1/2;         % actual probability
loglog(n,Aprime,'-b*',n,Aprime_1,'-y*',n,Aprime_2,'-r*')
hold on
loglog(n,abs((Aprime-Aactual)/Aactual),'-bo',n,abs((Aprime_1-Aactual_1)/Aactual_1),'-yo',n,abs((Aprime_2-Aactual_2)/Aactual_2),'-ro') % relative error
hold off
xlabel('n');
ylabel('Num_points/n');
title('Figure-2')
nexttile
semilogx(n,elapsed_time,'-ko')
xlabel('n');
ylabel('elapsed_time');
title('Figure-3')
grid off
