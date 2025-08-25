function dTE_out = analytical_dTE(lambda,R)
if (lambda<R)
    dTE_out=0;
elseif (lambda>=R |lambda<=2*R)
    %dTE_out = (R^2*(1+lambda*R))/(lambda*(lambda^2-R^2)*log(2))-(R/(lambda^2))*log2((lambda+R)/(lambda-R));
    dTE_out=(R/(2*(lambda^2)))*(log2((lambda-R)/(lambda+R)));
end
end