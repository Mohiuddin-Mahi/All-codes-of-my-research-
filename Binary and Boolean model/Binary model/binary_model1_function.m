%Matlab code:
% x_t is a fair coin toss
% y_(t+1) is x_t with pr 'a' or a fair coin toss with pr '1-a' for d<R and  
%y_(t+1) is a fair coin toss for d>=R. 

function[x_t,y_t]=binary_model1_function(TMAX,a,R)

x=randi([0 1],[1 TMAX]);       % It can also be written as x=randi(2,[1 TMAX])-1 
d =rand(1,TMAX)*2*R;           % d belongs to [0, 2R]
y(1)=1;
y= zeros(1,TMAX);

for t=1:TMAX-1
    if d(t) < R
        c=rand;              %% c is a random variable which takes a random value for probability at each iteration
        if c<=a
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