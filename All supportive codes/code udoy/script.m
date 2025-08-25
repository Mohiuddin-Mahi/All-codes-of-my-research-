clear all;clc
num_trials=1;
TMAX_array=[ 1e5];
R=2;
for TMAX_ind=1:length(TMAX_array)
    TMAX=TMAX_array(TMAX_ind);
    
    for trial_ind=1:num_trials
        X=[];Y=[];Z=[];
        [X, Y, Z] =binary_system(TMAX,R);
        X_t=[];X_t_1=[];Y_t=[];Y_t_1=[];
        X_t=X(1:end-1);
        X_t_1=X(2:end);
        Y_t=Y(1:end-1);
        Y_t_1=Y(2:end);
        V_x_x_y=[];V_y_y_x=[];
        V_x_x_y=[X_t_1' X_t' Y_t'];
        V_y_y_x=[Y_t_1' Y_t' X_t'];
        
        lambda=linspace(0,2*R,100);
        
        for l_ind=1:length(lambda)
            tic;
            cutoff=lambda(l_ind);
            delete_ind=[]
            delete_ind=find(Z>cutoff)
            
            data1=V_x_x_y;
            if(max(delete_ind)>length(data1))
                delete_ind(delete_ind>length(data1))=[];
            end
            data1(delete_ind,:)=[];
            
            data2=V_y_y_x;
            if(max(delete_ind)>length(data2))
                delete_ind(delete_ind>length(data2))=[];
            end
            data2(delete_ind,:)=[];
            data1=data1+1;
            data2=data2+1;
            TE_x_y{TMAX_ind}(trial_ind,l_ind)=probability_distribution_short_binary_model(data2,2);
            TE_y_x{TMAX_ind}(trial_ind,l_ind)=probability_distribution_short_binary_model(data1,2);
            toc
        end
    end
end

figure
for ind=1:length(TMAX_array)
    plot(lambda(2:end),diff(mean(TE_x_y{ind},1)),'linewidth',1.5)
    xlabel('Cutoff \lambda')
    ylabel('d<TE>/d\lambda')
    hold on
    xlim([0 2*R])
end
title(['R=',num2str(R)])
%legend('1e3','1e4','1e5','1e6','location','best');
set(gca,'fontsize',12)
print 100.tif -dtiff -r300

% figure
% for ind=1:length(TMAX_array)
%     plot(lambda,mean(TE_x_y{ind},1),'linewidth',1.5)
%     xlabel('Cutoff \lambda')
%     ylabel('<TE>')
%     hold on
%     xlim([0 2*R])
% end
% title(['R=',num2str(R)])
% %legend('1e3','1e4','1e5','1e6','location','best');
% set(gca,'fontsize',12)
% print 1.tif -dtiff -r300

%%%%%%% central difference formula %%%%%
figure
for ind1=1:length(TMAX_array)
    a=1;
    for ind=2:length(lambda)-1
        
        central_diff(a)=(TE_x_y{ind1}(ind-1)-TE_x_y{ind1}(ind+1))/(lambda(ind-1)-lambda(ind+1));
        a=a+1;
    end
end
plot(lambda(2:end-1),central_diff)
xlabel('Cutoff \lambda')
ylabel('<TE>')
hold on
xlim([0 2*R])
title('Central diff. formula')
%
% for i=1:length(lambda)
%     TE_out(i) = analytical_TE(lambda(i),R);
% end
% figure;
% plot(lambda,TE_out,'*r')
% hold on
% plot(lambda,TE_x_y{end})
% legend('Analytical TE','Simulated TE')
% xlabel('Cutoff \lambda')
% ylabel('<TE>')
% hold on
% title(['R=',num2str(R)])
% xlim([0 2*R])
% set(gca,'fontsize',12)
% print 3.tif -dtiff -r300
%
%
% for i=1:length(lambda)
%     for j=1:length(TMAX_array)
%         error(i,j)=abs(TE_x_y{j}(i)-TE_out(i));
%     end
% end
%
% figure;
% for i=1:length(TMAX_array)
% plot(lambda, error(:,i),'linewidth',1.5)
% hold on
% end
% xlabel('Cutoff \lambda')
% ylabel('|analytic-simulated|')
% set(gca,'fontsize',12)
% ylim([ 0 0.2])
% legend('1e3','1e4','1e5','1e6','location','best');
% print 4.tif -dtiff -r300
%
