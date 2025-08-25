function [Entropy]=en_npoints(pr)
%Entropy=0;
for i=1:2
    Entropy=Entropy-pr(i).*mmy_log2(pr(i))-(1-pr(i)).*mmy_log2(1-pr(i));
end
end
