function [symbols]=binary_models_func(TMAX,c,model_type)

switch (model_type)
    case('A')
        symbols=binary_model_A(TMAX,c)
    
    case 'B'
        symbols=binary_model_B(TMAX,c)
    
    case 'C'
        symbols=binary_model_C(TMAX,c)
   
    case 'D'
        symbols=binary_model_D(TMAX,c)
   
    case 'Cprime'
        symbols=binary_model_Cprime(TMAX,c)
    
    case 'Dprime'
        symbols=binary_model_Dprime(TMAX,c)
end
end
 
%%Type A: The model is y_(t+1)=x_t  where y(1)=0, and pr(x_t=1)=c & pr(x_t=0)=1-c.
%% y_t depends only on the past of x_t.

function [symbols]=binary_model_A(TMAX,c)
    status=rand(1,TMAX);
    y(1)=0;
    for ind=1:length(status)
        if status(ind)>c
            x(ind)=0;
        else
            x(ind)=1;
        end
        if ind<TMAX
            y(ind+1)=x(ind);
        end
    end
   symbols(:,1)=uint8(x);
   symbols(:,2)=uint8(y);
end

%%Type B: The model is y_(t)=x_(t-1) with pr 1-c and y_(t)=y_(t-1) with pr c where y(1)=0. There is confusion about this model. Need to be cleared.
%% y_t depends on the past of both x_t and y_t.

function [symbols]=binary_model_B(TMAX,c)
    x=randi(2,[1 TMAX])-1;                %% Here x=randi(r,[m n])=randi(r,[m,n])=randi(r,m,n) indicates a matrix of m by n ordered containing element from 1 to r.
    status=rand(1,TMAX);                  %% and x=randi(r,[m n])-1 means subtracting 1 from each element of x.
    y(1)=0;
    for ind=2:length(status)
        if status(ind)>c
            y(ind)=x(ind-1);
        else
            y(ind)=y(ind-1);
        end
    end
   symbols(:,1)=uint8(x);
   symbols(:,2)=uint8(y);
end

%%Type C: The model is y_(t)=x_(t-1), and x_(t)=x_(t-1) with pr c and x_t will be selected randomly with pr 1-c where y(1)=0, x(1)=0. There is confusion about this model. Need to be cleared.
%% y_t depends on the past of x_t, and x_t may be selected randomly or may dependent on the past of it.

function [symbols] = binary_model_C(TMAX,c)
x(1)=0;
y(1)=0;
status=rand(1,TMAX);
for ind=2:TMAX
    if status(ind)>c
        x(ind)=x(ind-1);
    else
        x(ind)=randi(2)-1;
    end
    y(ind)=x(ind-1);
end
symbols(:,1)=uint8(x);
symbols(:,2)=uint8(y);
end

%%Type D: 
function [symbols] = binary_model_D(TMAX,c)

x(1)=0;
status=rand(1,TMAX);
for ind=2:TMAX
    if status(ind)>c
        x(ind)=x(ind-1);
    else
        x(ind)=randi(2)-1;
    end
end
status=rand(1,TMAX);
y(1)=0;
for ind=2:TMAX
    if status(ind)>c
        y(ind)=x(ind-1);
    else
        y(ind)=y(ind-1);
    end
end
symbols(:,1)=uint8(x);
symbols(:,2)=uint8(y);
end

%Type Cprime:
function symbols = binary_model_Cprime(TMAX,c)

x(1)=0;
status=rand(1,TMAX);
for ind=2:TMAX
    if mod(ind,2)
        if status(ind)>c
            x(ind)=x(ind-1);
        else
            x(ind)=randi(2)-1;
        end
    else
        x(ind)=randi(2)-1;
    end
end
y(1)=0;
y(2:TMAX)=x(1:end-1);
symbols(:,1)=uint8(x);
symbols(:,2)=uint8(y);
end

%%Type Dprime:
function symbols = binary_model_Dprime(TMAX,c)

x(1)=0;
status=rand(1,TMAX);

for ind=2:TMAX
    
    if mod(ind,2)
        if status(ind)>c
            x(ind)=x(ind-1);
        else
            x(ind)=randi(2)-1;
        end
    else
        x(ind)=randi(2)-1;
    end
end
status=rand(1,TMAX);
y(1)=0;
for ind=2:TMAX
    if status(ind)>c
        y(ind)=x(ind-1);
    else
        y(ind)=y(ind-1);
    end
end
symbols(:,1)=uint8(x);
symbols(:,2)=uint8(y);

end

