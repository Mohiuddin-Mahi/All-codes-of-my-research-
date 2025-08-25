function [H,H1] = Entropy_func(p)
%write for loop to compute entropy
H=0;
H1=0;
for ind=1:length(p)
    if p(ind)~=0
        H=H+(-(p(ind).*log2(p(ind))));        % It will returns NAN for (0)log(0)
        H1=H1+(-(p(ind).*my_log2(p(ind))));   % It will returns 0 replace of NAN for (0)log(0)
    end
end
end