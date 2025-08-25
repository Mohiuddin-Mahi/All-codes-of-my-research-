%Mohiuddin:JCP's binary model with two cutoff distances.

% x_t is a fair coin toss
% y_(t+1) is x_t  for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

TMAX=1e5;
num_trails=600;
R=1;                % For different values of R=1,2,3,...
tau=1;
symbols=[0 1];

lambda1=linspace(0,2*R,100);
lambda2=linspace(0,2*R,100);
% TE_x_y=zeros(length(num_trails),length(lambda1));
TE2_x_y=zeros(length(lambda1),length(lambda2),length(num_trails));
% TE3_x_y=zeros(length(num_trails),length(lambda2));

for l_ind1=1:length(lambda1)
    for l_ind2=1:length(lambda2)
        tic;
        cutoff1=lambda1(l_ind1); cutoff2=lambda2(l_ind2);
        if (cutoff1<cutoff2)
            parfor trail_ind=1:num_trails
            [x_t,y_t,d]=binary_system(TMAX,R);
            X=x_t(1:end-tau);
            Y=y_t(1:end-tau);
            Y_t_1=y_t(tau+1:end);
            v_yyx=[Y_t_1' Y' X'];
%             delete_ind1=find(d>cutoff1); 
            delete_ind2=find(d<cutoff1 | d>cutoff2); 
%             keep_ind3=find(d>cutoff2);
%             data1=v_yyx;
            data2=v_yyx; 
%             data3=v_yyx;
                                   
%              if (max(delete_ind1)>length(data1))
%                 delete_ind1(delete_ind1>length(data1))=[];
%              end
%                 data1(delete_ind1,:)=[];
%                 data11=data1;
                        
              if (max(delete_ind2)>length(data2))
                  delete_ind2(delete_ind2>length(data2))=[];
              end
              data2(delete_ind2,:)=[];
              data12=data2;
                        
%               if (max(keep_ind3)>length(data3))
%                   keep_ind3(keep_ind3>length(data3))=[];
%               end
%               data13=data3(keep_ind3,:);
                    
%               TE_x_y(trail_ind,l_ind1)=transfer_ent_function(data11,symbols);
              TE2_x_y(l_ind1,l_ind2,trail_ind)= transfer_ent_function(data12,symbols);
%               TE3_x_y(trail_ind,l_ind2)= transfer_ent_function(data13,symbols); 
            end
        end
        toc
    end
end
[gx,gy]=gradient(mean(TE2_x_y,3));
[gx1,gy1]=gradient(mean(TE2_x_y,3),2);
magnitude=sqrt(gx.^2+gy.^2);
magnitude1=sqrt(gx1.^2+gy1.^2);

% % disp(TE_x_y)
% % disp(TE2_x_y)
% % disp(TE3_x_y)
 
% %% TE figure
% figure
% plot(lambda1,mean(TE_x_y,1))
% xlabel('Cutoff distance \lambda_1')
% ylabel('TE_x_y')
% title(['R=',num2str(R),' , ','d \leq \lambda_1'])
% xlim([0.1 2*R])
% % legend('d \leq \lambda_1','location','best');
% 
figure
surf(lambda1, lambda2,mean(TE2_x_y,3),'Edgecolor','none')
xlabel('Cutoff distance \lambda_1')
ylabel('Cutoff distance \lambda_2')
zlabel('TE_x_y')
xlim([0.1 2*R])
ylim([0.1 2*R])
title(['Transfer entropy(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_1 \leq d \leq \lambda_2'])
view(2)
colorbar
grid off
% %%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

% figure
% plot(lambda2,mean(TE3_x_y,1))
% xlabel('Cutoff distance \lambda_2')
% ylabel('TE_x_y')
% xlim([0.1 2*R])
% title(['R=',num2str(R),' , ', 'd > \lambda_2'])
% %%% legend('d>\lambda_2','location','best');
% 
% %%1st Derivative of TE
% 
% figure
% plot(lambda1(2:end),diff(mean(TE_x_y,1)))
% xlabel('Cutoff distance \lambda_1')
% ylabel('d(TE_x_y)/d\lambda_1')
% title(['R=',num2str(R),' , ','d \leq \lambda_1'])
% xlim([0.1 2*R])
% legend('d\leq\lambda_1','location','best');
% 
figure
surf(lambda1, lambda2,magnitude,'Edgecolor','none')
xlabel('Cutoff distance \lambda_1')
ylabel('Cutoff distance \lambda_2')
zlabel('|grad(TE_x_y)|')
xlim([0.1 2*R])
ylim([0.1 2*R])
title(['Magnitude of gradient(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_1 \leq d \leq \lambda_2'])
view(2)
colorbar
grid off
%%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

% figure
% plot(lambda2(2:end),diff(mean(TE3_x_y,1)))
% xlabel('Cutoff distance \lambda_2')
% ylabel('d(TE_x_y)/d\lambda_2')
% xlim([0.1 2*R])
% title(['R=',num2str(R),' , ','d > \lambda_2'])
% %% legend('d > \lambda_2','location','best');
%  
%  
% %% 2nd Derivative of TE
%  
% figure
% plot(lambda1(3:end),diff(mean(TE_x_y,1),2))
% xlabel('Cutoff distance \lambda_1')
% ylabel('d(TE_x_y)^2/d\lambda_1^2')
% title(['R=',num2str(R),' , ','d \leq \lambda_1'])
% xlim([0.1 2*R])
% legend('d \leq \lambda_1','location','best');
%  
figure
surf(lambda1, lambda2,magnitude1,'Edgecolor','none')
xlabel('Cutoff distance \lambda_1')
ylabel('Cutoff distance \lambda_2')
zlabel('|Grad^2(TE_x_y)|')
xlim([0.1 2*R])
ylim([0.1 2*R])
title(['Magnitude of two times gradient(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_1 \leq d \leq \lambda_2'])
view(2)
colorbar
grid off
% %%legend('\lambda_1 \leq d \leq \lambda_2','location','best');
% 
% figure
% plot(lambda2(3:end),diff(mean(TE3_x_y,1),2))
% xlabel('Cutoff distance \lambda_2')
% ylabel('d^2(TE_x_y)/d\lambda_2^2')
% xlim([0.1 2*R])
% title(['R=',num2str(R),' , ','d > \lambda_2'])
% %% legend('d > \lambda_2','location','best');
% 
