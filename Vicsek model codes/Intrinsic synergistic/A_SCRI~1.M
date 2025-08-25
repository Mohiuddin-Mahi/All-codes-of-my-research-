
%%%%%%%%%%%% Many followers interact only one leader with different weights %%%%%%%%%%%%%
%% If leaders interacts followers and followers also interact leaders and other followers, 
%% then W_LF= variations, W_LL=1, W_FF=1, W_FL=1.The wmatrix will be of the following form: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear all

%%% Input data %%%

TMAX=2e6;                                             %% number of time step
num_noise=40;
num_trail=20;                                         %% number of trails
num_follower=2;                                         %% number of leaders
leader_weight_array=[1,10,100,1000,10000,100000];                                             %% leader weight/strength
follower_to_Leader_weight=1;
follower_to_follower_weight=0;
nbird=3;

r=1;                                                  %%interaction radius                                                              
lbox=10;                                              %% box size in arb. unite
vs=0.3;                                               %% speed of the bird at each time step
dt=1;                                                 %% length of each time step
nsymbols=6;                                           %% number of symbols
noise_array=linspace(0,2*pi,num_noise);               %% noise


%%% Computation %%%

%%%%%% wmatrix for the interactions of model A multi leaders %%%%%%%
num_leader=nbird-num_follower;
wmatrix=eye(nbird);
for leader_weight_ind=1:length(leader_weight_array)
    leader_weight=leader_weight_array(leader_weight_ind);
    wmatrix(1:num_leader,1+num_leader:end)=follower_to_Leader_weight;
    for ind=1:num_follower-1
        wmatrix(ind+num_leader,(1+ind+num_leader):end)=follower_to_follower_weight;
        wmatrix((1+ind+num_leader):end,ind+num_leader)=follower_to_follower_weight;
    end
wmatrix(1+num_leader:end,1:num_leader)=leader_weight;
wmat=wmatrix
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%      for noise_ind=1:length(noise_array)
%          eta=noise_array(noise_ind);
%          parfor trail_ind=1:num_trail                                
%               tic
%               [theta_out,~,~] = modified_VM_multi_updated(lbox,vs,dt,r,eta,nbird,TMAX,wmat);
%               symbols{trail_ind}=uint8(get_symbol_strings(theta_out,nsymbols));
%               toc
%          end
%          save(['symbols_weight_',num2str(leader_weight),'_noise_',num2str(noise_ind)],'symbols')
%       end
end


%%% Complete %%%%



