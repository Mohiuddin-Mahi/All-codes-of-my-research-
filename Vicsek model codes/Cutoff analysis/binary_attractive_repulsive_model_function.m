

%%%%%% Mohiuddin: Binary model for attractive and repulsive force %%%%%%%
%%% x_t is a fair coin toss
%%% y_(t+1) is negation(x_t) when dt<=R1 , or x_t when R1<dt<=R2 , or a fair coin toss when dt>R2. 

function [x_t,y_t,d]=binary_attractive_repulsive_model_function(TMAX,R1,R2)

x=randi([0 1],[1 TMAX]);
R=2*(R1+R2);
d =rand(1,TMAX)*R;   
y= zeros(1,TMAX);

for t=1:TMAX-1              
    if d(t)<= R1
       y(t+1)=~(x(t));
    elseif (R1<d(t)) && (d(t)<=R2)
       y(t+1)=x(t);
    else
       y(t+1)=randi([0 1],[1 1]);
    end
end

x_t=x;
y_t=y;
end

%%%% Complete %%%%