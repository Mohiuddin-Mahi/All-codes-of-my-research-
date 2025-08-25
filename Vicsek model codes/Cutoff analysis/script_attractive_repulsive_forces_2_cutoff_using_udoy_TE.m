

%%%% Mohiuddin:Computation of the binary model for attaractive and repulsive forces using Udoy's TE function %%%%%

%%% x_t is a fair coin toss
%%% y_(t+1) is negation(x_t) when dt<=R1 , or x_t when R1<dt<=R2 , or a fair coin toss when dt>R2. 

clc; clear all

TMAX=1e5;
num_trails=500;
num_points=100;
R1=0.3;
R2=1;
R=2*(R1+R2);
tau=1;
nsymbols=2;

lambda1=linspace(0,R,num_points);
lambda2=linspace(0,R,num_points);
transfer_entropy=zeros(length(lambda1),length(lambda2),length(num_trails));

for l_ind1=1:length(lambda1)
    cutoff1=lambda1(l_ind1); 
    for l_ind2=1:length(lambda2)
        cutoff2=lambda2(l_ind2);
        tic;
        parfor trail_ind=1:num_trails
            if cutoff1>cutoff2
                [x_t,y_t,d]= binary_attractive_repulsive_model_function(TMAX,R1,R2);
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
                data1=data+1;   
                transfer_entropy(l_ind1,l_ind2,trail_ind)= probability_distribution_short_binary_model(data1,nsymbols);                
            else
                transfer_entropy(l_ind1,l_ind2,trail_ind)=NaN;
            end
        end
        toc
    end
end

TE_x_y=mean(transfer_entropy,3);
[gx,gy]=gradient(TE_x_y);
[gx1,gy1]=gradient(TE_x_y,2);
magnitude=sqrt(gx.^2+gy.^2);
magnitude1=sqrt(gx1.^2+gy1.^2);


%%% Transfer entropy

figure
surf(lambda2, lambda1,TE_x_y,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('TE_x_y')
xlim([0 R])
ylim([0 R])
set(gca, 'YDir','reverse')
title(['TE_x_\rightarrow_y',' , ','R_1=',num2str(R1),' , ','R_2=',num2str(R2), ' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

% % % % 1st derivative
figure
surf(lambda2, lambda1,magnitude,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('|nabla(TE_x_y)|')
xlim([0 R])
ylim([0 R])
set(gca, 'YDir','reverse')
title(['|\nabla(TE_x_\rightarrow_y)|',' , ','R_1=',num2str(R1),' , ','R_2=',num2str(R2), ' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%legend('\lambda_1 \leq d \leq \lambda_2','location','best');


% % % %% 2nd Derivative of TE

figure
surf(lambda2, lambda1,magnitude1,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('|\nabla^2(TE_x_y)|')
xlim([0 R])
ylim([0 R])
set(gca, 'YDir','reverse')
title(['|\nabla^2(TE_x_\rightarrow_y)|',' , ','R_1=',num2str(R1),' , ','R_2=',num2str(R2), ' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

