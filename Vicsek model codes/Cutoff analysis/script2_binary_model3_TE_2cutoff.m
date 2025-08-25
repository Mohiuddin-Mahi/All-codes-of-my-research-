%Mohiuddin:Binary model3 with two cutoff distances.

% x_t is a fair coin toss
% y_(t+1) is x_t with pr '1-d/R' or a fair coin toss with pr 'd/R' for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

TMAX=1e5;
num_trails=300;
R=1;                % For different values of R=1,2,3,...
tau=1;
symbols=[0 1];

lambda1=linspace(0,2*R,100);
lambda2=linspace(0,2*R,100);
for l_ind1=1:length(lambda1)
    parfor l_ind2=1:length(lambda2)
        tic;
        for trail_ind=1:num_trails
        %x_t=[];y_t=[];d=[];
        [x_t,y_t,d]=binary_model3_function(TMAX,R);
        %X=[];Y=[];Y_t_1=[];
        X=x_t(1:end-tau);
        Y=y_t(1:end-tau);
        Y_t_1=y_t(tau+1:end);
        %v_yyx=[];
        v_yyx=[Y_t_1' Y' X'];
        cutoff1=lambda1(l_ind1);
        cutoff2=lambda2(l_ind2);
        % delete_ind1=[]; 
        %delete_ind2=[]; 
        %keep_ind3=[];
        % delete_ind1=find(d>cutoff1); 
          delete_ind2=find(d<cutoff1 | d>cutoff2); 
        keep_ind3=find(d>cutoff2);
        % data1=v_yyx;
          data2=v_yyx; 
          data3=v_yyx;
                       
        % if (max(delete_ind1)>length(data1))
        % delete_ind1(delete_ind1>length(data1))=[];
        % end
        % data1(delete_ind1,:)=[];
        % data11=data1;
            
         if (max(delete_ind2)>length(data2))
            delete_ind2(delete_ind2>length(data2))=[];
         end
         data2(delete_ind2,:)=[];
         data12=data2;
            
        if (max(keep_ind3)>length(data3))
        keep_ind3(keep_ind3>length(data3))=[];
        end
        data13=data3(keep_ind3,:);
            
        %TE_x_y(trail_ind,l_ind1)=transfer_ent_function(data11,symbols);
        TE2_x_y(l_ind1,l_ind2,trail_ind)= transfer_ent_function(data12,symbols);
        TE3_x_y(trail_ind,l_ind2)= transfer_ent_function(data13,symbols); 
        end
        toc
    end
end
% 
% disp(TE_x_y)
% disp(TE2_x_y)
% disp(TE3_x_y)
 
%% TE figure
% figure
% plot(lambda1,mean(TE_x_y,1))
% xlabel('Cutoff \lambda1')
% ylabel('TE_x_y')
% title(['R=',num2str(R)])
% xlim([0.1 2*R])
% legend('d<=\lambda1','location','best');

figure
surf(lambda1, lambda2,mean(TE2_x_y,3))
xlabel('Cutoff \lambda1')
ylabel('Cutoff \lambda2')
zlabel('TE_x_y')
xlim([0.1 2*R])
ylim([0.1 2*R])
title(['R=',num2str(R)])
legend('\lambda1<=d<=\lambda2','location','best');

figure
plot(lambda2,mean(TE3_x_y,1))
xlabel('Cutoff \lambda2')
ylabel('TE_x_y')
xlim([0.1 2*R])
title(['R=',num2str(R)])
legend('d>\lambda2','location','best');

% 1st Derivative of TE

% figure
% plot(lambda1(2:end),diff(mean(TE_x_y,1)))
% xlabel('Cutoff \lambda1')
% ylabel('d(TE_x_y)/d\lambda1')
% title(['R=',num2str(R)])
% xlim([0.1 2*R])
% legend('d<=\lambda1','location','best');

figure
surf(lambda1, lambda2,gradient(mean(TE2_x_y,3)))
xlabel('Cutoff \lambda1')
ylabel('Cutoff \lambda2')
zlabel('Grad(TE_x_y)')
xlim([0.1 2*R])
ylim([0.1 2*R])
title(['R=',num2str(R)])
legend('\lambda1<=d<=\lambda2','location','best');

figure
plot(lambda2(2:end),diff(mean(TE3_x_y,1)))
xlabel('Cutoff \lambda2')
ylabel('d(TE_x_y)/d\lambda2')
xlim([0.1 2*R])
title(['R=',num2str(R)])
legend('d>\lambda2','location','best');
 
 
%% 2nd Derivative of TE
 
% figure
% plot(lambda1(3:end),diff(mean(TE_x_y,1),2))
% xlabel('Cutoff \lambda1')
% ylabel('d(TE_x_y)^2/d\lambda1^2')
% title(['R=',num2str(R)])
% xlim([0.1 2*R])
% legend('d<=\lambda1','location','best');
%  
figure
surf(lambda1, lambda2,gradient(mean(TE2_x_y,3),2))
xlabel('Cutoff \lambda1')
ylabel('Cutoff \lambda2')
zlabel('(Grad(TE_x_y))^2')
xlim([0.1 2*R])
ylim([0.1 2*R])
title(['R=',num2str(R)])
legend('\lambda1<=d<=\lambda2','location','best');

figure
plot(lambda2(3:end),diff(mean(TE3_x_y,1),2))
xlabel('Cutoff \lambda2')
ylabel('d^2(TE_x_y)/d\lambda2^2')
xlim([0.1 2*R])
title(['R=',num2str(R)])
legend('d>\lambda2','location','best');

