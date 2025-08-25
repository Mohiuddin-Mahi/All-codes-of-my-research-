clc;clear all;close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%In probabiity function we have used [1,2,3,4,5,6] symbols
%For different sequance of symbols, we need to change there
%Sequence should not contain any 0 symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%
warning 'In probabiity function we have used [1,2,3,4,5,6] symbols'
warning 'For different sequance of symbols, we need to change there'
warning 'Sequence should not contain any 0 symbol'
r=2;
% nbird=3;
ncell=3;
num_leaders=1;
lbox=10;
vs=0.3;
dt=1;
nsymbols=6;
weight=1.1;

r_array=[linspace(0,5,16) (lbox/2)*sqrt(2)];
theta_array=linspace(0,2*pi,15);
% weight_factor=ones(nbird,nbird);
% weight_factor(num_leaders+1:end,1:num_leaders)=weight;
wmat=ones(ncell,ncell);
wmat(num_leaders+1:end,1:num_leaders)=weight;

noise_array=linspace(0,2*pi,10);

TMAX=1000;
k=1;l=1;d=1;
for noise_ind=1:length(noise_array)
    eta=noise_array(noise_ind);
    parfor i=1:40                   %% number of trails
        tic
        [theta_out,x_out,y_out] = modified_VM_multi_updated(lbox,vs,dt,r,eta,ncell,TMAX,wmat);
%       [theta_out,x_out,y_out]=vicsek_April_2020_Udoy(lbox,vs,dt,r,eta,nbird,TMAX,weight_factor);
        symbols{i}=uint8(get_symbol_strings(theta_out,nsymbols));
%         for cell1=1:ncell
%             for cell2=1:ncell
%                 if (cell1~=cell2)                                                
%                     %% bird1 interacts with bird2
%                     TE{noise_ind,trial_ind}(cell1,cell2)=probability_distribution_short(symbols(cell2,:),symbols(cell1,:),nsymbols,k,l,d);
%                 else
%                     TE{noise_ind,trial_ind}(cell1,cell2)=0;
%                 end
%             end
%         end
        toc
    end
    save(['symbols_noise_',num2str(noise_ind)],'symbols')
end

% for i=1:length(noise_array)
%     for j=1:40
%         TE_L_F(i,j)=TE{i,j}(1,2);
%         TE_F_L(i,j)=TE{i,j}(2,1);
%     end
% end
% 
% figure
% plot(noise_array,mean(TE_L_F,2))
% hold on
% plot(noise_array,mean(TE_F_L,2))
% hold on

