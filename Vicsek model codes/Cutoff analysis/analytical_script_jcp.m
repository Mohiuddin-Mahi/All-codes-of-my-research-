%Mohiuddin:JCP Binary model with two cutoff distances.

% x_t is a fair coin toss
% y_(t+1) is x_t for d<=R and  
%y_(t+1) is a fair coin toss for d>R. 

R=1;                % For different values of R=1,2,3,...

lambda1=linspace(0,2*R,100);
lambda2=linspace(0,2*R,100);
TE_x_y=zeros(length(lambda1),length(lambda2));

for l_ind1=1:length(lambda1)
    cutoff1=lambda1(l_ind1);
    for l_ind2=1:length(lambda2)
        cutoff2=lambda2(l_ind2);
        tic;
        TE_x_y(l_ind1,l_ind2)=analytical_te_jcp_function(cutoff1,cutoff2,R);    
        toc
    end
end
[gx,gy]=gradient(TE_x_y);
[gx1,gy1]=gradient((TE_x_y),2);
magnitude=sqrt(gx.^2+gy.^2);
magnitude1=sqrt(gx1.^2+gy1.^2);

% % disp(TE_x_y)

% heatmap(lambda2,lambda1,TE_x_y,'GridVisible','off','colormap',jet)
% xlabel('\lambda_2')
% ylabel('\lambda_1')
 
figure
surf(lambda2, lambda1,TE_x_y,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('TE_x_y')
xlim([0 2*R])
ylim([0 2*R])
set(gca, 'YDir','reverse')
title(['Transfer entropy(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

%%% 1st derivative
figure
surf(lambda2, lambda1,magnitude,'Edgecolor','none')
xlabel('Cutoff distance \lambda_2')
ylabel('Cutoff distance \lambda_1')
zlabel('|grad(TE_x_y)|')
xlim([0 2*R])
ylim([0 2*R])
set(gca, 'YDir','reverse')
title(['Magnitude of gradient(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
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
zlabel('|Grad^2(TE_x_y)|')
xlim([0 2*R])
ylim([0 2*R])
set(gca, 'YDir','reverse')
title(['Magnitude of two times gradient(TE_x_y)',' , ','R=',num2str(R),' , ','\lambda_2 \leq d \leq \lambda_1'])
view(2)
colorbar
colormap(jet)
grid off
%%legend('\lambda_1 \leq d \leq \lambda_2','location','best');

