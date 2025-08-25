

function tran_ent_comput_two_cutoff_resample_autocorr_range(d,tau,lbox,ncell,num_trail,noise_array,...
    nsymbols,num_lambda,max_lambda)

lambda1=linspace(0,max_lambda,num_lambda);
lambda2=linspace(0,max_lambda,num_lambda);

for noise_ind=1:4%length(noise_array)

    data=load(['symbols_resample_autocorr_range/symbols_noise_',num2str(noise_ind),'.mat']);

    data_sym=data.symbols;
    x_val=data.x_value;
    y_val=data.y_value;

    for cell1=1:ncell
        for cell2=1:ncell
            
            if (cell1<cell2)
                tran_ent=zeros(length(lambda1),length(lambda2));
                for l_ind1=1:length(lambda1)
                    cutoff1=lambda1(l_ind1);
                    for l_ind2=1:length(lambda2)
                        cutoff2=lambda2(l_ind2);

                        if cutoff1>cutoff2
                            tic
                            temp_te=zeros(1,num_trail);
                            parfor trail_ind=1:num_trail

                                y1=data_sym{trail_ind}(cell2,d+tau:end);
                                y=data_sym{trail_ind}(cell2,d:end-tau);
                                x=data_sym{trail_ind}(cell1,d:end-tau);

                                diff_x=abs(x_val{trail_ind}(cell1,d:end)-x_val{trail_ind}(cell2,d:end));
                                diff_y=abs(y_val{trail_ind}(cell1,d:end)-y_val{trail_ind}(cell2,d:end));

                                mdiff_x=min(diff_x,lbox-diff_x);
                                mdiff_y=min(diff_y,lbox-diff_y);
                                dist=sqrt((mdiff_x).^2+(mdiff_y).^2);

                                data_y1yx=[y1' y' x'];

                                delete_ind=find(dist<=cutoff2 | dist>cutoff1);

                                if (max(delete_ind)>length(data_y1yx))
                                    delete_ind(delete_ind>length(data_y1yx))=[];
                                end

                                data_y1yx(delete_ind,:)=[];
                                temp_te(1,trail_ind)= function_transfer_entropy_two_cutoff(data_y1yx,nsymbols);

                            end
                            tran_ent(l_ind1,l_ind2)=mean(temp_te);
                            toc
                        else
                            tran_ent(l_ind1,l_ind2)=NaN;
                        end

                    end
                end
                save(['data_te_resample_autocorr_range/te_cell_',num2str(cell1),'_',num2str(cell2),'_noise_',num2str(noise_ind),'.mat'],'tran_ent')
            end

        end
    end

end