function con_en=conditional_entropy_short(X,Y,num_symbol,delay)
%%Probability of x %%%
x=X(delay:end);
y=Y(1:end-delay);
pr_x = probability(x);
pr_y = probability(y);
%%probabiity x and y%%%
vec_x=fliplr(sequence_prob(x,1));
vec_y=fliplr(sequence_prob(y,1));
%vec_x_y=[vec_x(1:end,:) vec_y(1:end,:)];
for ind1=1:num_symbol
    for ind2=1:num_symbol
       n_x_y(ind1, ind2) = length(find(vec_x==ind1 & vec_y == ind2));
    end
end
pr_x_y = n_x_y./length(vec_x);


%mutual information%

% for ind=1:size(tmp_x_y_1,1)
%     p(ind)=find(ismember(tmp_x_1,tmp_x_y_1(ind,1),'rows'));
%     q(ind)= find(ismember(tmp_y_1,tmp_x_y_1(ind,2),'rows'));
%     %r(ind)=find(ismember(tmp_x_y_1,tmp_x_x_y_1(ind,[2:end]),'rows'));
% end
%  mi=0;
% % for i=1:size(tmp_x_y_1,1)
% %     mi= mi+pr_x_y(i)*log2(pr_x_y(i)/(pr_x(p(i))*pr_y(q(i))));
% % end
con_en=0;
for ind1=1:num_symbol
    for ind2=1:num_symbol
        if pr_x(ind1)~=0 & pr_y(ind2) ~=0 & pr_x_y(ind1,ind2)~=0
            con_en = con_en + pr_x_y(ind1,ind2) * log2(pr_x_y(ind1,ind2)/(pr_y(ind2)));
        end
    end
end
con_en=-con_en;
end
