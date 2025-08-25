clear all;clc;close all
num_noise=21;
num_trials=1;
num_weights=1;
nbird=2;
tmax_array=[1e3 1e4 1e5];
num_r=2;
shared_ratio=0;
noise=linspace(0,2*pi,num_noise);

r=3;
lbox=10;
vs=0.3;
dt=1;
nsymbols=6;
num_leaders=1;
beta=0.0;
use_phi=0;




delta0=0;
time_scale=NaN;


a=linspace(0,5,num_r);
max_r = sqrt( (lbox/2)^2 + (lbox/2)^2); %% we need to keep it fixed
r_array=[a max_r];







interaction_types={'no_memory','no_follower_memory','no_leader_memory','with_memory','no_follower_memory_randomize_every_two','with_memory_randomize_every_two'};

l_to_f_weights=1;
f_to_l_weights=1;
%save('Apr1_params.mat');;
interaction_type=interaction_types{1};

randomize_L_every_two=0;
weight_ind=1;



switch(interaction_type)
    case 'no_memory'
        weight=l_to_f_weights(weight_ind);
        weight_factor=[1 0; weight 1];
        randomize_followers=1;
        randomize_leaders=1;
    case 'no_follower_memory'
        weight=l_to_f_weights(weight_ind);
        weight_factor=[1 0; weight 1];
        randomize_followers=1;
        randomize_leaders=0;
    case 'no_follower_memory_randomize_every_two'
        randomize_L_every_two=1;
        weight=l_to_f_weights(weight_ind);
        weight_factor=[1 0; weight 1];
        randomize_followers=1;
        randomize_leaders=0;
    case 'no_leader_memory'
        weight=l_to_f_weights(weight_ind);
        weight_factor=[1 1; weight 1];
        randomize_followers=0;
        randomize_leaders=1;
    case 'with_memory'
        weight=l_to_f_weights(weight_ind);
        weight_factor=[1 1; weight 1];
        randomize_followers=0;
        randomize_leaders=0;
    case 'with_memory_randomize_every_two'
        randomize_L_every_two=1;
        weight=l_to_f_weights(weight_ind);
        weight_factor=[1 0; weight 1];
        randomize_followers=0;
        randomize_leaders=0;
end
fig_ind=1;
figure;
for tmax_ind=1:length(tmax_array)
    TMAX=tmax_array(tmax_ind);
    save_str=strcat(interaction_type,num2str(randomize_followers),'_shared_ratio_',num2str(shared_ratio),'_TMAX_',num2str(TMAX),'_weight_',num2str(weight),'_',datestr(now,'mmddyyyy'));
    save_str(save_str=='.')='p';
    
    for noise_ind=1:length(noise)
        eta=noise(noise_ind);
        
        for i=1%:num_trials
            
            
            tic
            [theta_out,delete_inds,x_out,y_out] = vicsek_protocol_A_try2(lbox,vs,dt,r,eta,nbird,TMAX,num_leaders,weight_factor,beta,delta0,time_scale,r_array,randomize_followers,randomize_leaders,shared_ratio,randomize_L_every_two);
            toc
            %         for x_ind=1:length(x_out)
            %             for y_ind=1:length(y_out)
            %                 Z{noise_ind,i}=sqrt((x_out(1,i)-x_out(2,i))^2+(y_out(1,i)-y_out(2,i))^2);
            %             end
            %         end
            diff_x=abs(x_out(1,:)-x_out(2,:));
            diff_y=abs(y_out(1,:)-y_out(2,:));
            
            min_diff_x=min(diff_x,lbox-diff_x);
            min_diff_y=min(diff_y,lbox-diff_y);
            distance=sqrt(min_diff_x.^2+min_diff_y.^2);
            %             figure
            %             hist(distance,100)
            Z{tmax_ind}{noise_ind,i}=get_symbol_strings_for_Z((sqrt((x_out(1,:)-x_out(2,:)).^2+(y_out(1,:)-y_out(2,:)).^2)),nsymbols);
            symbols=uint8(get_symbol_strings(theta_out,nsymbols));
            symbols_data{tmax_ind}{noise_ind,i}=symbols;
            
            
        end
        if(tmax_ind==3) & (noise_ind==3||noise_ind==13||noise_ind==19)
        [~,data{noise_ind}]=entropy(Z{tmax_ind}{noise_ind,i});
        subplot(3,1,fig_ind)
        heatmap(data{noise_ind})
        colormap(jet)
        xlabel('Symbols')
        title(['Noise=', num2str(noise(noise_ind)) ])
        fig_ind=fig_ind+1;
        end
         con_x_t_given_y_t(tmax_ind,noise_ind)=conditional_entropy_x_given_y(symbols_data{tmax_ind}{noise_ind}(1,:),symbols_data{tmax_ind}{noise_ind}(2,:),nsymbols);
         con_y_t_1_given_y_t(tmax_ind,noise_ind)=conditional_entropy_x_given_y(symbols_data{tmax_ind}{noise_ind}(2,2:end),symbols_data{tmax_ind}{noise_ind}(2,1:end-1),nsymbols);
        con_x_t_given_z_t(tmax_ind,noise_ind)=conditional_entropy_x_given_y(symbols_data{tmax_ind}{noise_ind}(1,:),Z{tmax_ind}{noise_ind}(1,:),nsymbols);
                 [H_X(tmax_ind,noise_ind),~]=entropy(symbols_data{tmax_ind}{noise_ind}(1,:));
                 [H_Y_1(tmax_ind,noise_ind),~]=entropy(symbols_data{tmax_ind}{noise_ind}(2,2:end));
        % save([save_str,'_',num2str(noise_ind),'.mat'],'symbols_data')
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
heatmap(noise,tmax_array,abs(con_x_t_given_z_t-H_X))
colormap(jet)
xlabel('Noise')
ylabel('TMAX')
title('|H(X_t|Z_{t})-H(X_t)|')
% 
figure;
heatmap(noise,tmax_array,abs(con_y_t_1_given_y_t-H_Y_1))
colormap(jet)
xlabel('Noise')
ylabel('TMAX')
title('|H(Y_{t+1}|Y_{t})-H(Y_{t+1})|')
% 
figure;
heatmap(noise,tmax_array,abs(con_x_t_given_y_t-H_X))
colormap(jet)
xlabel('Noise')
ylabel('TMAX')
title('|H(X_t|Y_t)-H(X_t)|')
%
% figure;
% for tmax_ind=1:length(tmax_array)
% plot(noise,con_x_t_given_y_t(tmax_ind,:))
% hold on
% end
% plot(noise,H_X(3,:))
% ylim([2.5 2.6])
% xlim([0 2*pi])
% legend('T=1e3','T=1e4','T=1e5','H(X)')
% xlabel('Noise')
% ylabel('H(X_t|Y_t)')
%
% figure;
% for tmax_ind=1:length(tmax_array)
% plot(noise,con_y_t_given_y_t_1(tmax_ind,:))
% hold on
% end
% plot(noise,H_Y(3,:))
% ylim([2.5 2.6])
% xlim([0 2*pi])
% legend('T=1e3','T=1e4','T=1e5','H(Y)')
% xlabel('Noise')
% ylabel('H(Y_t|Y_t_{+1})')
%
% figure;
% for tmax_ind=1:length(tmax_array)
% plot(noise,con_x_t_given_z_t(tmax_ind,:))
% hold on
% end
% plot(noise,H_X(3,:))
% ylim([2.5 2.6])
% xlim([0 2*pi])
% legend('T=1e3','T=1e4','T=1e5','H(X)')
% xlabel('Noise')
% ylabel('H(X_t|Z_t)')
%
% figure;
% fig_ind=1;
% for i=1:3
%     subplot(3,1,fig_ind)
% [~,pr_x]=entropy(symbols_data{i}{12,1}(2,:));
% [~,pr_x]=entropy(Z{i}{12,1});
% heatmap(pr_x)
% xlabel('Symbols')
% ylabel('P(Z)')
% title(['TMAX=',num2str(tmax_array(i)),' noise=', num2str(noise(12))])
% fig_ind=fig_ind+1;
% caxis([0.16 0.18])
% end
%
