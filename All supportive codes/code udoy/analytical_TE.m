function TE_out = analytical_TE(lambda,R)

if (lambda<R)
    TE_out=1;
elseif (lambda>=R |lambda<=2*R)
    TE_out = (R+lambda)/(2*lambda) * log2(( R+lambda)/lambda) + (lambda-R)/(2*lambda) * log2( (lambda-R) /lambda);
end
end