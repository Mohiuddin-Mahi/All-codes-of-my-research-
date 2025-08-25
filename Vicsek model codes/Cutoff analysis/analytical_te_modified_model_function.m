%Mohiuddin:Binary model3 with two cutoff distances.

% x_t is a fair coin toss
% y_(t+1) is x_t with pr '1-d/R' or a fair coin toss with pr 'd/R' for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

function[te_x_y]=analytical_te_modified_model_function(cutoff1,cutoff2,dis,R)
d=dis;

if (cutoff1>cutoff2)
    if (cutoff2<R && R<cutoff1)
        te_x_y=((R*(R+cutoff1-2*cutoff2)+d*(cutoff2-R))/(2*R*(cutoff1-cutoff2)))*log2((R*(R+cutoff1-2*cutoff2)+d*(cutoff2-R))/(R*(cutoff1-cutoff2)))...
            +((R*(cutoff1-R)+d*(R-cutoff2))/(2*R*(cutoff1-cutoff2)))*log2((R*(cutoff1-R)+d*(R-cutoff2))/(R*(cutoff1-cutoff2)));
    elseif (cutoff2<R && cutoff1<R)
        te_x_y=((2*R-d)/(2*R))*log2((2*R-d)/R)+(d/(2*R))*log2(d/R);
    else
        te_x_y=0;
    end
else
    te_x_y=NaN;
end
end
