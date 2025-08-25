
function function_stat_test_two_cutoff_resample_autocorr_range(d,tau,lbox,ncell,num_trail,noise_array,nsymbols,num_lambda,...
    max_lambda,alpha)

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
                all_pr=zeros(length(lambda1),length(lambda2));
                pass_or_fail=zeros(length(lambda1),length(lambda2));
                true_te=zeros(length(lambda1),length(lambda2));
                surr_te=cell(length(lambda1),length(lambda2));

                for l_ind1=1:length(lambda1)
                    cutoff1=lambda1(l_ind1);
                    for l_ind2=1:length(lambda2)
                        cutoff2=lambda2(l_ind2);

                        if cutoff1>cutoff2
                            tic
                            temp_tr_te=zeros(1,num_trail);
                            new_data=cell(1,num_trail);
                            new_data_length=zeros(1,num_trail);
                            temp_surr_te=[];

                            for trail_ind=1:num_trail
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
                                new_data{1,trail_ind}=data_y1yx;
                                new_data_length(1,trail_ind)=size(data_y1yx,1);
                            end

                            %%%%%%%% True te and Surrogate te computation %%%%%%%%%%%%%

                            min_length=min(new_data_length);
                            parfor trail1=1:num_trail
                                for trail2=1:num_trail
                                    data_1=[new_data{trail2}(1:min_length,1:2) new_data{trail1}(1:min_length,3)];
                                    if trail1==trail2
                                        temp_tr_te(trail1)= function_transfer_entropy_two_cutoff(data_1,nsymbols);
                                    else
                                        temp= function_transfer_entropy_two_cutoff(data_1,nsymbols);
                                        temp_surr_te=[temp_surr_te;temp];
                                    end
                                end
                            end

                            %%%%%%%%%% statistical test %%%%%%%%%%%%%%%%%

                            tr_te=mean(temp_tr_te);
                            mdi= temp_surr_te;         % surro data set %
                            cb=1-alpha;                % confidence level%
                            ce=cumsum(1/numel(mdi)*ones(1,numel(mdi)));
                            smd=sort(mdi,'ascend');
                            d_cut=smd(find(ce<=cb,1,'last'));

                            curr_pass_or_fail=1;        %%%% assume that curr_pass_or_fail=1 means significant
                            all_pr(l_ind1,l_ind2)=d_cut;
                            pass_or_fail(l_ind1,l_ind2) = curr_pass_or_fail & (tr_te > d_cut);

                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                            true_te(l_ind1,l_ind2)=tr_te;
                            surr_te{l_ind1,l_ind2}=temp_surr_te;
                            toc
                        else
                            all_pr(l_ind1,l_ind2)=NaN;
                            pass_or_fail(l_ind1,l_ind2) =NaN;
                            true_te(l_ind1,l_ind2)=NaN;
                            surr_te{l_ind1,l_ind2}=NaN;
                        end

                    end
                end
                save(['data_te_resample_autocorr_range/stat_test_cell_',num2str(cell1),'_',num2str(cell2),'_noise_',num2str(noise_ind)],...
                    'all_pr','pass_or_fail','true_te','surr_te')
            end

        end
    end

end
