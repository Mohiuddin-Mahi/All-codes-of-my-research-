%Mohiuddin:Binary model3

% x_t is a fair coin toss
% y_(t+1) is x_t with pr '1-d/R' or a fair coin toss with pr 'd/R' for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

clc;clear all;close all

TMAX=[1e7];
num_trails=400;
R=1;                % For different values of R=1,2,3,...
tau=1;
symbols=[1 2];
%nsymbols=2;

for trail_ind=1:num_trails
   tic;
    X=[]; Y=[]; Z=[];
    [X,Y,Z]=binary_model3_function(TMAX,R);
    x_t=[]; y_t=[]; y_t_1=[];
    x_t=X(1:end-tau);
    y_t=Y(1:end-tau);
    y_t_1=Y(tau+1:end);
    v_yyx=[];
    v_yyx=[y_t_1' y_t' x_t'];
    lambda=linspace(0,2*R,100);

    parfor l_ind=1:length(lambda)
        cutoff=lambda(l_ind);
        delete_ind=[];
        delete_ind=find(Z>cutoff);
        data=v_yyx;
        if (max(delete_ind)>length(data))
            delete_ind(delete_ind>length(data))=[];   %% It will remove those index from delete_ind which are greater then the length(data)
        end
        data(delete_ind,:)=[];                        %% It will remove those rows from data which are equal to the element of delete_ind.
        %data1=data;
        data1=data+1;
        TE_x_y(trail_ind,l_ind)= transfer_ent_function(data1,symbols);
        %TE_x_y(trail_ind,l_ind)=probability_distribution_short_binary_model(data1,nsymbols);
    end
    toc
end

%disp(TE_x_y)

figure
plot(lambda,mean(TE_x_y,1),'k-','linewidth',1.5)
xlabel('Cutoff \lambda')
ylabel('TE_x_y')
title(['R=',num2str(R)])
xlim([0.1 2*R])
%legend('Model for probability 1-d/R','location','best');

figure
plot(lambda(2:end),diff(mean(TE_x_y,1)),'k-','linewidth',1.5)
xlabel('Cutoff \lambda')
ylabel('d(TE_x_y)/d\lambda')
title(['R=',num2str(R)])
xlim([0.1 2*R])
%legend('Model for probability 1-d/R','location','best');

figure
plot(lambda(3:end),diff(diff(mean(TE_x_y,1))),'k-','linewidth',1.5)
xlabel('Cutoff \lambda')
ylabel('d^2(TE_x_y)/d\lambda^2')
title(['R=',num2str(R)])
xlim([0.1 2*R])
%legend('Model for probability 1-d/R','location','best');
 