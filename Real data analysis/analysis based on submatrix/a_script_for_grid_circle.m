

clc
close all
clear;


lambda1=2;
lambda2=1;

r1=lambda1;
r2=lambda2;
a=0;
b=0;

th = 0:pi/6:2*pi;
x1unit = r1 * cos(th) + a;
y1unit = r1 * sin(th) + b;
x2unit = r2 * cos(th) + a;
y2unit = r2 * sin(th) + b;
x = -lambda1:lambda1;
y = -lambda1:lambda1;
[X,Y]=meshgrid(x,y);

figure;
hold on;
plot(X,Y,'k');
plot(Y,X,'k');
plot(x1unit, y1unit, '-b','LineWidth',2)
plot(x2unit, y2unit, '-r','LineWidth',2)
set(gca, 'YDir','reverse')
