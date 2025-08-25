%Mohiuddin: Binary model
% x_t is a fair coin toss
% y_(t+1) is x_t with pr '1-d/R' or a fair coin toss with pr 'd/R' for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

function [x_t,y_t,d]=binary_model3_function(TMAX,R)

x=randi([0 1],[1 TMAX]);      
d =rand(1,TMAX)*2*R;   
y(1)=1;
y= zeros(1,TMAX);
for t=1:TMAX-1
    a=rand;              
    if d(t) <= R
        if  a<(1-(d(t)/R))
            y(t+1)=x(t);
        else
            y(t+1)=randi([0 1],[1 1]);
        end
    else
        y(t+1)=randi([0 1],[1 1]);
    end
end
x_t=x;
y_t=y;
end