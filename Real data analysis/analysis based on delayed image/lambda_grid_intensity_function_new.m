

function  lambda_grid_intensity_corrected=lambda_grid_intensity_function_new(ind,max_lambda,row_num,...
    col_num,fig_indx)

load(['large_image_binarized_data/large_image_binarized_data_',num2str(ind,'%.3d'),'.mat'],'curr_imData')

lambda_grid_intensity_corrected=cell(row_num,col_num);

x_length_data1=1+max_lambda:(size(curr_imData,1)-max_lambda);
y_length_data1=1+max_lambda:(size(curr_imData,2)-max_lambda);

x_length_data=x_length_data1(1:end);
y_length_data=y_length_data1(1:end-2);                                        %%% why 2 has been subtracted ?

x_length=floor(length(x_length_data)/row_num)-1;
y_length=floor(length(y_length_data)/col_num)-1;

x_vals=1+max_lambda:x_length:x_length_data(end);
y_vals=1+max_lambda:y_length:y_length_data(end);

if(fig_indx==1)
    figure;
    imshow(curr_imData,[0 1])
    hold on
    for i=1:length(x_vals)
        plot([y_vals(1) y_vals(end)],[x_vals(i) x_vals(i)],'-b','linewidth',2)
    end
    for i=1:length(y_vals)
        plot([y_vals(i) y_vals(i)],[x_vals(1) x_vals(end)],'-b','linewidth',2)
    end
end

for x_ind=1:row_num
    for y_ind=1:col_num

        curr_x=x_vals(x_ind);
        curr_y=y_vals(y_ind);

        lambda_x_corrected=curr_x-max_lambda:curr_x+x_length+max_lambda;
        lambda_y_corrected=curr_y-max_lambda:curr_y+y_length+max_lambda;
        lambda_grid_intensity_corrected{x_ind,y_ind}=curr_imData(lambda_x_corrected,lambda_y_corrected);

        if (fig_indx==1)
            plot([lambda_y_corrected(1) lambda_y_corrected(1)],[lambda_x_corrected(1) lambda_x_corrected(end)],'-r','linewidth',2)
            plot([lambda_y_corrected(end) lambda_y_corrected(end)],[lambda_x_corrected(1) lambda_x_corrected(end)],'-r','linewidth',2)
            plot([lambda_y_corrected(1) lambda_y_corrected(end)],[lambda_x_corrected(end) lambda_x_corrected(end)],'-r','linewidth',2)
            plot([lambda_y_corrected(1) lambda_y_corrected(end)],[lambda_x_corrected(1) lambda_x_corrected(1)],'-r','linewidth',2)
        end

    end
end


end
