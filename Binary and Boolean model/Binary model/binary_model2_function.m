%Mohiuddin
% x_t is a fair coin toss
% y_(t+1) is x_t with pr '1-d' or a fair coin toss with pr 'd' for d<R and  
%y_(t+1) is a fair coin toss for d>=R. 

function [x_t,y_t,d]=binary_model2_function(TMAX,R)

x=randi([0 1],[1 TMAX]);       % It can also be written as x=randi(2,[1 TMAX])-1 
d =rand(1,TMAX)*2*R;           % d is [0,2R] where R must be 1/2. Because for greater value od 1/2 in 1-d the pr will be negative.
y(1)=1;
y= zeros(1,TMAX);
for t=1:TMAX-1
    a=rand;                   %% a is a random variable which takes a random value for probability at each iteration
    if d(t) < R
        if  a<(1-d(t))
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