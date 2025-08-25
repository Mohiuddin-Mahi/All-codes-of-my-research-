clc;clear all;
%% Input data:
r=2;                                                  %%interaction radius                                                              
lbox=10;                                              %% box size in arb. unite
vs=0.3;                                               %% speed of the bird at each time step
dt=1;                                                 %% length of each time step
nsymbols=6;                                           %% number of symbols
weight=1.5;                                           %% leader weight/strength
TMAX=1e5;                                            %% number of time step
k=1;l=1;d=1;                                          %% d is time delay and k,l represent difference between time steps of each time series

nbird_array=[2,4,6,8];                                %% number of birds (nbird>=2)
num_noise=30;
noise_array=linspace(0,2*pi,num_noise);               %% noise
num_trail=40;                                         %% number of trails

%% Computation:
for bird_ind=1:length(nbird_array)
    nbird=nbird_array(bird_ind);
    num_leaders=1;                                     %% number of leaders

    %% If leader interacts with follower and follower also interacts with leader, then W_LF=1.1(since leader is more influencial),
    %% W_LL=1, W_FF=1 and W_FL=1.The wmatrix will be of the following form: 
    wmat=ones(nbird); 
    wmat(num_leaders+1:end,1:num_leaders)=weight;

    %% If aLL leaders interact with follower but leaders don't interact with another leader, and follower does not interact with leaders, then W_LF=1,
    %% W_LL=1, W_FF=1 and W_FL=0. The wmatrix will be of the following form: 
%     wmat=eye(nbird); 
%     wmat(end,:)=weight;

    for noise_ind=1:length(noise_array)
        eta=noise_array(noise_ind);
        parfor trial_ind=1:num_trail                                
            tic
            [theta_out,x_out,y_out] = modified_VM_multi_updated(lbox,vs,dt,r,eta,nbird,TMAX,wmat);
            symbols=uint8(get_symbol_strings(theta_out,nsymbols));
            for bird1=1:nbird
                for bird2=1:nbird
                    if (bird1~=bird2)                                                
                        %% bird1 interacts with bird2
                        TE{trial_ind}(bird1,bird2)=probability_distribution_short(symbols(bird2,:),symbols(bird1,:),nsymbols,k,l,d);
                    else
                        TE{trial_ind}(bird1,bird2)=0;
                    end
                end
            end
           toc
        end
         save(['TE_nbird_',num2str(nbird),'_noise_',num2str(noise_ind),'.mat'],'TE')
    %     save(['symbols_noise_',num2str(noise_ind)],'symbols')
    end
end




