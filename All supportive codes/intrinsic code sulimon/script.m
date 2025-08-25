
clear all;clc
data=xlsread('firing_data_129_cells.xlsx');
nbird=127;
start_ind=251;
end_ind=400;
for i=1:nbird
    firing_data(i,:)=data(:,i+1);
    
end
format long
% x=[1, 1, 1, 2, 2, 1, 1 ];
% y=[2, 2, 2, 1, 1, 1, 1 ];
for d=3
    
    for bird1=1:nbird
        bird1_firing=firing_data(bird1,:)+1;
        parfor bird2=1:nbird
            bird2_firing=firing_data(bird2,:)+1;
                
                pr=only_probability_distribution(bird1_firing,bird2_firing,2,1,1,d);
%                 val(1)=pr(1,1,1);
%                 val(2)=pr(1,2,1);
%                 val(3)=pr(2,1,1);
%                 val(4)=pr(2,2,1);
%                 val(5)=pr(1,1,2);
%                 val(6)=pr(1,2,2);
%                 val(7)=pr(2,1,2);
%                 val(8)=pr(2,2,2);
                save_str= strcat('_',num2str(start_ind),'_to_',num2str(end_ind),'_',num2str(bird1),'_',num2str(bird2),'_',num2str(d),'.mat')
                command=['sshpass -p udoy01717 ssh udoy@192.168.1.92 nohup python /home/udoy/Horikawas_data_for_intrinsic/intrinsic_code_from_PD.py ',num2str(pr(1,1,1),'%.15f') ' ' ...
                    num2str(pr(1,2,1),'%.15f') ' ' num2str(pr(2,1,1),'%.15f') ' ' num2str(pr(2,2,1),'%.15f') ' '...
                    num2str(pr(1,1,2),'%.15f') ' ' num2str(pr(1,2,2),'%.15f') ' ' num2str(pr(2,1,2),'%.15f') ' '...
                    num2str(pr(2,2,2),'%.15f') ' ' save_str]
                system(command);         %TE is the output obtained from Python
                
                command=['pscp -pw udoy01717 udoy@192.168.1.92:/home/udoy/Mar23/Results',save_str,' /home/s/Desktop/intrinsic_for_firing_data/'];
                
                system(command);           %TE is the output obtained from Python
                %TE_result{d}(bird1,bird2)=TE;
     
        end
    end
end
