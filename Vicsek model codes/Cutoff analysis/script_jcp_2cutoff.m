%Mohiuddin:JCP's binary model with two cutoff distances.

% x_t is a fair coin toss
% y_(t+1) is x_t  for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

TMAX=1e5;
num_trails=100;
R=1;                % For different values of R=1,2,3,...
tau=1;
symbols=[0 1];

lambda1=linspace(0,2*R,100);
lambda2=linspace(0,2*R,100);
TE_x_y=zeros(length(lambda1),length(lambda2),length(num_trails));
TE1_x_y=zeros(length(lambda1),length(lambda2));

for l_ind1=1:length(lambda1)
    cutoff1=lambda1(l_ind1); 
    for l_ind2=1:length(lambda2)
        cutoff2=lambda2(l_ind2);
        tic;
        parfor trail_ind=1:num_trails
            if cutoff1>cutoff2
                [x_t,y_t,d]= binary_system(TMAX,R);
                X=x_t(1:end-tau);
                Y=y_t(1:end-tau);
                Y_t_1=y_t(tau+1:end);
                v_yyx=[Y_t_1' Y' X'];
                delete_ind=find(d<cutoff2 | d>cutoff1); 
                data=v_yyx;                            
                if (max(delete_ind)>length(data))
                    delete_ind(delete_ind>length(data))=[];
                end
                data(delete_ind,:)=[];
                data1=data;   
                TE_x_y(l_ind1,l_ind2,trail_ind)= transfer_ent_function(data1,symbols);
            else
                TE_x_y(l_ind1,l_ind2,trail_ind)=NaN;
            end
        end
        TE1_x_y(l_ind1,l_ind2)=analytical_te_jcp_function(cutoff1,cutoff2,R);
        toc
    end
end

expected_te=mean(TE_x_y,3);
% actual_te=TE1_x_y;
% relative_error=abs(expected_te-actual_te)./actual_te;


[gx,gy]=gradient(mean(TE_x_y,3));
[gx1,gy1]=gradient(mean(TE_x_y,3),2);
magnitude=sqrt(gx.^2+gy.^2);
magnitude1=sqrt(gx1.^2+gy1.^2);

% % disp(TE_x_y)

%%% Transfer entropy

figure
surf(lambda2, lambda1,expected_te,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('TE_X_\rightarrow_Y')
xlim([0 2*R])
ylim([0 2*R])
set(gca, 'YDir','reverse')
% title(['Expected(TE_X_\rightarrow_Y)',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
title(['TE_X_\rightarrow_Y',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

% figure
% surf(lambda2, lambda1,actual_te,'Edgecolor','none')
% xlabel('Cutoff distance \lambda_2')
% ylabel('Cutoff distance \lambda_1')
% zlabel('TE_x_y')
% xlim([0 2*R])
% ylim([0 2*R])
% set(gca, 'YDir','reverse')
% title(['Actual(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
% view(2)
% colorbar
% colormap(jet)
% grid off
% %legend('\lambda_1 \leq d \leq \lambda_2','location','best');

% %%% RELATIVE ERROR
% figure
% surf(lambda2, lambda1,relative_error,'Edgecolor','none')
% xlabel('Cutoff distance \lambda_2')
% ylabel('Cutoff distance \lambda_1')
% zlabel('TE_x_y')
% xlim([0 2*R])
% ylim([0 2*R])
% set(gca, 'YDir','reverse')
% title(['Relative Error(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
% view(2)
% colorbar
% colormap(jet)
% grid off
% %%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

% 1st derivative
figure
surf(lambda2, lambda1,magnitude,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('|\nabla(TE_X_\rightarrow_Y)|')
xlim([0 2*R])
ylim([0 2*R])
set(gca, 'YDir','reverse')
title(['|\nabla(TE_X_\rightarrow_Y)|',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%legend('\lambda_1 \leq d \leq \lambda_2','location','best');


%% 2nd Derivative of TE

figure
surf(lambda2, lambda1,magnitude1,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('|\nabla^2(TE_X_\rightarrow_Y)|')
xlim([0 2*R])
ylim([0 2*R])
set(gca, 'YDir','reverse')
title(['|\nabla^2(TE_X_\rightarrow_Y)|',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

