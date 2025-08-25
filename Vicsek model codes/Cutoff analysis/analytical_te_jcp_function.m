function [te_x_y] = analytical_te_jcp_function(cutoff1,cutoff2,R)

if (cutoff1>cutoff2)
    if(cutoff2<R && cutoff1>R)
        te_x_y=((R+cutoff1-2*cutoff2)/(2*(cutoff1-cutoff2)))*log2((R+cutoff1-2*cutoff2)/(cutoff1-cutoff2))+((cutoff1-R)/(2*(cutoff1-cutoff2)))*log2((cutoff1-R)./(cutoff1-cutoff2));
    elseif(cutoff2<R && cutoff1<R)
        te_x_y=1;
    else
        te_x_y=0;
    end
else
    te_x_y=NaN;
end
end
