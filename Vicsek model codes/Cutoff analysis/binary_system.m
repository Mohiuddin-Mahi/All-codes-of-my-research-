%%%%JCP Binary model:By Udoy
% function [X, Y, Z] = binary_system(TMAX,R)
%   Z = 2*R*rand([1 TMAX-1]);
%   X=randi(2,[1 TMAX])-1;
%   Y(1)=0;
%   Z_lth_r=find(Z>R);
%   Z_ge_r = find(Z<=R);
%   Y(Z_ge_r+1)=X(Z_ge_r);
%   Y(Z_lth_r+1)=randi(2,[1 length(Z_lth_r)])-1;
% end





%% Alternative:By Mohiuddin
function [X, Y, Z] = binary_system(TMAX,R)

X=randi(2,[1 TMAX])-1;         %% Also can be written as X=randi([0 1],[1 TMAX])
Z=2*R*rand(1,TMAX);            %% Also can be written as Z=2*R*rand([1 TMAX])
Y(1)=0;
for t=1:TMAX-1
    if (Z(t)<=R)
        Y(t+1)=X(t);
    else
        Y(t+1)=randi(2)-1;    %% Also can be written as X=randi([0 1],[1 1])
    end
end
end

