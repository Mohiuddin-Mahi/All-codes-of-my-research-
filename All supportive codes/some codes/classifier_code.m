clear all;clc
nbird=3;
noise=linspace(0,2*pi,10);
ntrial=40;
for i=1:nbird
    for j=i+1:nbird
        load(['result_',num2str(i),'_',num2str(j),'.mat'])
    end
end
for noise_ind=1:length(noise)
    tic
    for trial_ind=1:ntrial
        A1=zeros(nbird,nbird);
        for i=1:nbird
            for j=i+1:nbird
                data11=eval(['intrinsic_',num2str(i),'_',num2str(j)]);
                data12=eval(['r_intrinsic_',num2str(i),'_',num2str(j)]);
                
                data21=eval(['transfer_entropy_',num2str(i),'_',num2str(j)]);
                data22=eval(['r_transfer_entropy_',num2str(i),'_',num2str(j)]);
                
                data31=eval(['TDMI_',num2str(i),'_',num2str(j)]);
                data32=eval(['r_TDMI_',num2str(i),'_',num2str(j)]);
                
                
                data41=eval(['shared_',num2str(i),'_',num2str(j)]);
                data42=eval(['r_shared_',num2str(i),'_',num2str(j)]);
                
                
                data51=eval(['synergistic_',num2str(i),'_',num2str(j)]);
                data52=eval(['r_synergistic_',num2str(i),'_',num2str(j)]);
                
                A1(i,j)=data11(noise_ind,trial_ind)-data12(noise_ind,trial_ind);
                A2(i,j)=data21(noise_ind,trial_ind)-data22(noise_ind,trial_ind);
                A3(i,j)=data31(noise_ind,trial_ind)-data32(noise_ind,trial_ind);
                A4(i,j)=data41(noise_ind,trial_ind)-data42(noise_ind,trial_ind);
                A5(i,j)=data51(noise_ind,trial_ind)-data52(noise_ind,trial_ind);
            end
        end
        for bird1=1:nbird
            for bird2=1:nbird
                if(bird1>bird2)
                    A1(bird1,bird2)=-A1(bird2,bird1);
                    A2(bird1,bird2)=-A2(bird2,bird1);
                    A3(bird1,bird2)=-A3(bird2,bird1);
                    A4(bird1,bird2)=-A4(bird2,bird1);
                    A5(bird1,bird2)=-A5(bird2,bird1);
                end
            end
        end
         intrinsic_classifier{noise_ind}(trial_ind,:)=mean(A1,2);
         TE_classifier{noise_ind}(trial_ind,:)=mean(A2,2);
         TDMI_classifier{noise_ind}(trial_ind,:)=mean(A3,2);
         shared_classifier{noise_ind}(trial_ind,:)=mean(A4,2);
         synergistic_classifier{noise_ind}(trial_ind,:)=mean(A5,2);
        
    end
    toc
end
clearvars -except intrinsic_classifier TE_classifier TDMI_classifier shared_classifier synergistic_classifier nbird noise ntrial

% for i=1:nbird
%     for j=i+1:nbird
%         load(['result_',num2str(i),'_',num2str(j),'.mat'])
%     end
% end
% for noise_ind=1:length(noise)
%     tic
%     for trial_ind=1:ntrial
%         A1=zeros(nbird,nbird);
%         for i=1:nbird
%             for j=i+1:nbird
%                 data11=eval(['intrinsic_',num2str(i),'_',num2str(j)]);
%                 data12=eval(['r_intrinsic_',num2str(i),'_',num2str(j)]);
%                 
%                 data21=eval(['transfer_entropy_',num2str(i),'_',num2str(j)]);
%                 data22=eval(['r_transfer_entropy_',num2str(i),'_',num2str(j)]);
%                 
%                 data31=eval(['TDMI_',num2str(i),'_',num2str(j)]);
%                 data32=eval(['r_TDMI_',num2str(i),'_',num2str(j)]);
%                 
%                 
%                 data41=eval(['shared_',num2str(i),'_',num2str(j)]);
%                 data42=eval(['r_shared_',num2str(i),'_',num2str(j)]);
%                 
%                 
%                 data51=eval(['synergistic_',num2str(i),'_',num2str(j)]);
%                 data52=eval(['r_synergistic_',num2str(i),'_',num2str(j)]);
%                 
%                 A1(i,j)=data11(noise_ind,trial_ind)-data12(noise_ind,trial_ind);
%                 A2(i,j)=data21(noise_ind,trial_ind)-data22(noise_ind,trial_ind);
%                 A3(i,j)=data31(noise_ind,trial_ind)-data32(noise_ind,trial_ind);
%                 A4(i,j)=data41(noise_ind,trial_ind)-data42(noise_ind,trial_ind);
%                 A5(i,j)=data51(noise_ind,trial_ind)-data52(noise_ind,trial_ind);
%             end
%         end
%         for bird1=1:nbird
%             for bird2=1:nbird
%                 if(bird1>bird2)
%                     A1(bird1,bird2)=-A1(bird2,bird1);
%                     A2(bird1,bird2)=-A2(bird2,bird1);
%                     A3(bird1,bird2)=-A3(bird2,bird1);
%                     A4(bird1,bird2)=-A4(bird2,bird1);
%                     A5(bird1,bird2)=-A5(bird2,bird1);
%                 end
%             end
%         end
%          intrinsic_classifier{noise_ind}(trial_ind,:)=mean(A1,2);
%          TE_classifier{noise_ind}(trial_ind,:)=mean(A2,2);
%          TDMI_classifier{noise_ind}(trial_ind,:)=mean(A3,2);
%          shared_classifier{noise_ind}(trial_ind,:)=mean(A4,2);
%          synergistic_classifier{noise_ind}(trial_ind,:)=mean(A5,2);
%         
%     end
%     toc
% end
% clearvars -except intrinsic_classifier TE_classifier TDMI_classifier shared_classifier synergistic_classifier
 save('classifier.mat')