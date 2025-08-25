
function script_symbols_boolean_model()

clc
close all
clear;

tmax=2e6;
nbird=3;
num_trail=20;
num_theta=11;
num_coup=11;
coup_array=linspace(0,1,num_coup);
theta_array=linspace(0,0.25,num_theta);

%%%%%%%%%%%%%%%%%%%%%%%%

wmatrix=eye(nbird);
wmatrix(2,1)=1;
wmatrix(3,2)=1;
wmat=wmatrix;

for theta_ind=1:length(theta_array)
    theta=theta_array(theta_ind);
    for coup_ind=1:length(coup_array)
        gamma=coup_array(coup_ind);
        tic;
        parfor trail_ind=1:num_trail
            [symbols_out] = function_Boolean_model(tmax,nbird,wmat,theta,gamma);
            symbols{trail_ind}=symbols_out'+1;
        end
        save(['symbols/symbols_theta_',num2str(theta_ind),'_coup_',num2str(coup_ind),'.mat'],'symbols')
        toc;
    end

end

