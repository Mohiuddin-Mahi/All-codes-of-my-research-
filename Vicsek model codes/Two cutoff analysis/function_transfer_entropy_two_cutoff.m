
function [tr_en1]=function_transfer_entropy_two_cutoff(data,nsymbols)

tr_en1=0;
if (isempty(data))
    tr_en1=0;
else

    %%%% Compute probability of y1,y,x  %%%%             %% i for y1, j for y and k for x %%%

    vec_y1yx = data;
    [tmp_y1yx_1,~,tmp_y1yx_3]=unique(vec_y1yx,'rows');
    [a,~]=size(tmp_y1yx_1);
    counts = histcounts(tmp_y1yx_3,1:(a+1));
    pr_y1yx=counts./size(vec_y1yx,1);

    new_pr_y1yx=zeros(nsymbols,nsymbols,nsymbols);
    new_pr_y1y=zeros(nsymbols,nsymbols);
    new_pr_yx=zeros(nsymbols,nsymbols);
    new_pr_y=zeros(1,nsymbols);

    if (~isempty(tmp_y1yx_1))
        for ind1=1:size(tmp_y1yx_1,1)
            curr_symbol=tmp_y1yx_1(ind1,:);
            new_pr_y1yx(curr_symbol(1),curr_symbol(2),curr_symbol(3))=pr_y1yx(ind1);
        end
    end


    %% probabiity y and x %%%
    for j=1:nsymbols
        for k=1:nsymbols
            pr=0;
            for i=1:nsymbols
                pr=pr+new_pr_y1yx(i,j,k);
            end
            new_pr_yx(j,k)=pr;
        end
    end
    %%probabiity y1 and y %%%
    for i=1:nsymbols
        for j=1:nsymbols
            pr=0;
            for k=1:nsymbols
                pr=pr+new_pr_y1yx(i,j,k);
            end
            new_pr_y1y(i,j)=pr;
        end
    end
    %%Probability of y %%%
    for j=1:nsymbols
        pr=0;
        for i=1:nsymbols
            for k=1:nsymbols
                pr=pr+new_pr_y1yx(i,j,k);
            end
        end
        new_pr_y(j)=pr;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for i=1:nsymbols
        for j=1:nsymbols
            for k=1:nsymbols
                if(new_pr_y1yx(i,j,k)~=0 && new_pr_y1y(i,j)~=0 && ...
                        new_pr_yx(j,k)~=0 && new_pr_y(j)~=0)
                    tr_en1=tr_en1+new_pr_y1yx(i,j,k)*log2(new_pr_y1yx(i,j,k)*new_pr_y(j)/...
                        (new_pr_yx(j,k)*new_pr_y1y(i,j)));
                end
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end