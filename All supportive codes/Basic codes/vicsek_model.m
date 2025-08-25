% This code is made to give a primer for those who want to enjoy the Vicsek model simulation.
% Reference: 1995, Vicsek, T. et al., PRL
%%
clc
clear all
close all
%%
TMAX=1000;              % number of time steps
L=7;                    % domain size
noise=2.0;              % noise
N=300;                  % particle number
r=1;                    % interacting radius
vel=0.03;               % absolute velocity 
dt=1;                   % each time step
%% Boundary condition
PERIODIC=1;             % 1: periodic boundary condition, 0: unlimited
%% Initial condition
x=L*rand(1,N);
y=L*rand(1,N);
theta=2*pi*(rand(1,N)-0.5);       % randomly distributed on [0, 2pi]
%plot(x,y,'.','MarkerSize',15)
for time=1:TMAX
   
    %% Calculation of average angle in the interacting circle
    D = pdist([x' y'],'euclidean');    %% returns pairwise eucledian distances between particles. Let A=[x1 y1;x2 y2;x3 y3] is a matrix of 3 by 2 ordered.It's pairwise
                                       % euclidean distances are sqrt((x1-x2)^2+(y1-y2)^2), sqrt((x1-x3)^2+(y1-y3)^2) and sqrt((x2-x3)^2+(y2-y3)^2).
                                       % Again let A=[x1 y1 z1;x2 y2 z2;x3 y3 z3] is a matrix of 3 by 3 ordered.It's pairwise
                                       % euclidean distances are sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2), sqrt((x1-x3)^2+(y1-y3)^2+(z1-z3)^2) and sqrt((x2-x3)^2+(y2-y3)^2+(z2-z3)^2).
    
    % Periodic boundary %
    if PERIODIC==1
        tmp_x(x<r) = x(x<r) + L;        % See the slide of basic of information theory for explanation
        tmp_x(x>L-r) = x(x>L-r)-L;
        tmp_x(r<=x & x<=L-r) = x(r<=x & x<=L-r);
        tmp_y(y<r) =y(y<r) + L;
        tmp_y(y>L-r) = y(y>L-r) - L;
        tmp_y(r<=y & y<=L-r) = y(r<=y & y<=L-r);
        
        tmp_D = pdist([tmp_x' tmp_y'],'euclidean');        
        D = min([D; tmp_D]);          %% It can also be written as  D = min(D,tmp_D)
    end
    
        M = squareform(D);            % Matrix representation for the distance between particles
        [l1,l2]=find(0<M & M<r);      % Returns the row and column subscripts of non zero elements of M which are greter than 0 and less than r.
    
    for i = 1:N
        list = l1(l2==i);
        if ~isempty(list)             %% isempty(A) returns logical true (1) if A is an empty array and logical false (0) otherwise
           
            ave_theta(i) = atan2(mean(sin(theta(list))),mean(cos(theta(list))));         
            %% atan2(y,x) computes the inverse tangent of (y/x) in the interval[-pi,pi] or [0, 2pi]. Here y = v * sin(α) and x = v * cos(α) are 
            % projections of a vector with length v and angle α on the y- and x-axis,respectively. On the other hand, atan(y/x) computes the inverse 
            % tangent of (y/x) in the interval[-pi/2,pi/2].
       
        else
            ave_theta(i) = theta(i);
        end
    end
    
    %% Update
    x = x + vel*cos(theta)*dt;
    y = y + vel*sin(theta)*dt;
    
    if PERIODIC==1
        x(x<0) = x(x<0) + L;              % See the slide of basic of information theory for explanation
        x(L<x) = x(L<x) - L;
        y(y<0) = y(y<0) + L;
        y(L<y) = y(L<y) - L;
    end
    theta = ave_theta + noise*(rand(1,N) - 0.5);
    
    %% Figure
    plot(x,y,'.','MarkerSize',15)
    xlim([0 L]);
    ylim([0 L]);
    axis square
    pause(0.1)
end