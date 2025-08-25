%Mohiuddin:Binary model3 with two cutoff distances.

% x_t is a fair coin toss
% y_(t+1) is x_t with pr '1-d/R' or a fair coin toss with pr 'd/R' for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

clc;clear all;close all

TMAX=[1e5];
R=1/2;                % For different values of R=1,2,3,...
tau=1;
symbols=[0 1];

x_t=[];y_t=[];d=[];

[x_t,y_t,d]=binary_model3_function(TMAX,R);

X=[];Y=[];Y_t_1=[];
X=x_t(1:end-tau);
Y=y_t(1:end-tau);
Y_t_1=y_t(tau+1:end);
v_yyx=[];
v_yyx=[Y_t_1' Y' X'];

lambda1=linspace(0,2*R,100);
lambda2=linspace(0,2*R,100);
tic;
for l_ind1=1:length(lambda1)
    for l_ind2=1:length(lambda2)
        
        cutoff1=lambda1(l_ind1);
        cutoff2=lambda2(l_ind2);
        delete_ind1=[]; delete_ind2=[]; keep_ind3=[];
        delete_ind1=find(d>cutoff1);
        delete_ind2=find(d<cutoff1 | d>cutoff2);
        keep_ind3=find(d>cutoff2);
        data1=v_yyx; data2=v_yyx;data3=v_yyx;

        if (max(delete_ind1>length(data1)))
            delete_ind1(delete_ind1>length(data1))=[];
        end
        data1(delete_ind1,:)=[];
        data11=data1;

        if (max(delete_ind2>length(data2)))
            delete_ind2(delete_ind2>length(data2))=[];
        end
        data2(delete_ind2,:)=[];
        data12=data2;

        if (max(keep_ind3>length(data3)))
            keep_ind3(keep_ind3>length(data3))=[];
        end
        data13=data3(keep_ind3,:);

        time_series_x1=[data11(:,3)]'; time_series_y1=[data11(:,2)]'; time_series_y1_t_1=[data11(:,1)]';
        time_series_x2=[data12(:,3)]'; time_series_y2=[data12(:,2)]'; time_series_y2_t_1=[data12(:,1)]';
        time_series_x3=[data13(:,3)]'; time_series_y3=[data13(:,2)]'; time_series_y3_t_1=[data13(:,1)]';

        TE_x_y(l_ind1)= transfer_ent_function(time_series_x1,time_series_y1,time_series_y1_t_1,symbols);
        TE2_x_y(l_ind1,l_ind2)= transfer_ent_function2(time_series_x2,time_series_y2,time_series_y2_t_1,symbols);
        TE3_x_y(l_ind2)= transfer_ent_function3(time_series_x3,time_series_y3,time_series_y3_t_1,symbols);
    end
end
toc
%disp(TE_x_y)
%disp(TE2_x_y)
%disp(TE3_x_y)


%figure
plot(lambda1,TE_x_y)
xlabel('Cutoff \lambda1')
ylabel('TE_x_y')
title(['R=',num2str(R)])
%legend('d<\lambda1','location','best');

figure
surf(lambda1,lambda2,TE2_x_y)
xlabel('Cutoff \lambda1')
ylabel('Cutoff \lambda2')
zlabel('TE2_x_y')
title(['R=',num2str(R)])
%legend('\lambda1<d<\lambda2','location','best');

figure
plot(lambda2,TE3_x_y)
xlabel('Cutoff \lambda2')
ylabel('TE3_x_y')
title(['R=',num2str(R)])
%legend('\lambda2<d','location','best');

%tiledlayout(3,1)
%nexttile
%plot(lambda(1:end),(TE_x_y),'k-')
%xlabel('Cutoff \lambda')
%ylabel('d(TE_x_y)/d\lambda')
%title(['R=',num2str(R)])
%legend('d<\lambda1','location','best');

%nexttile
%plot(lambda(1:end),(TE2_x_y),'r-')
%xlabel('Cutoff \lambda')
%ylabel('d(TE_x_y)/d\lambda')
%title(['R=',num2str(R)])
%legend('\lambda1<d<\lambda2','location','best');

%nexttile
%plot(lambda(1:end),(TE3_x_y),'g-')
%xlabel('Cutoff \lambda')
%ylabel('d(TE_x_y)/d\lambda')
%title(['R=',num2str(R)])
%legend('\lambda2<d','location','best');




%figure
%plot(lambda,TE_x_y,'k-',lambda,TE3_x_y,'g-','linewidth',1.5)
%xlabel('Cutoff \lambda')
%ylabel('TE_x_y')
%title(['R=',num2str(R)])
%legend('TE_x_y','TE3_x_y','location','best');

%figure
%plot(lambda(2:end),diff(TE_x_y),'k-','linewidth',1.5)
%xlabel('Cutoff \lambda')
%ylabel('d<TE_x_y>/d\lambda')
%title(['R=',num2str(R)])
%legend('Model: x_t=FCT, y_(t+1)=x_t w. pr 1-d/R or FCT w. pr d/R when d<=R','location','best');

%figure
%plot(lambda(1:end-2),diff(diff(TE_x_y)),'k-','linewidth',1.5)
%xlabel('Cutoff \lambda')
%ylabel('d^2<TE_x_y>/d\lambda^2')
%title(['R=',num2str(R)])
%legend('Model: x_t=FCT, y_(t+1)=x_t w. pr 1-d/R or FCT w. pr d/R when d<=R','location','best');