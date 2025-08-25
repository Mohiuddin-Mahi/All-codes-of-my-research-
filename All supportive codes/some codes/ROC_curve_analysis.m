function [TPR,FPR,AUC] = ROC_curve_analysis(curr_data)

num_thld=1000;

thld_vals=linspace(min(min(curr_data)),max(max(curr_data)),num_thld);
num_trials=size(curr_data,1);

for ind=1:length(thld_vals)
    thld=thld_vals(ind);
    for ind2=1:num_trials
        classes(ind,ind2,:)= curr_data(ind2,:)>thld;  %% classes(ind,ind2,:), where ind for thld num, ind2 & : for row & col of curr_data 
    end
end

for ind=1:1:num_thld
    curr_classes=classes(ind,:,:);
    
    curr_classes1=curr_classes(:,:,1);
    
    true_positives(ind)=length(find(curr_classes1(:)==1));
    
    false_negatives(ind)=length(find(curr_classes1(:)~=1));
    
    curr_classes=curr_classes(:,:,2:end);
    
    true_negatives(ind)=length(find(curr_classes(:)~=1));
    false_positives(ind)=length(find(curr_classes(:)==1));
    
end

TPR = true_positives./(true_positives + false_negatives);

FPR = false_positives./(false_positives+true_negatives);

AUC=trapz(FPR(end:-1:1),TPR(end:-1:1));

%all_areas=this_area;



