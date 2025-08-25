function [output] = my_log2(p)
    output(p==0)=0;
    output(p~=0)=log2(p(p~=0));
end

