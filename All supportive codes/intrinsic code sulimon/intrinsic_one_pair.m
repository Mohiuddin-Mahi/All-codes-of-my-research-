function [intrinsic_1_2,r_intrinsic_1_2,transfer_entropy_1_2,r_transfer_entropy_1_2,TDMI_1_2,r_TDMI_1_2] = intrinsic_one_pair(symbols_data)

tname=strcat(tempname,'.mat');
save_str=[tname(1:end-4),'_',num2str(1),'.mat'];
save(save_str,'symbols_data')

command=['pscp -pw udoy01717 ',save_str ' udoy@192.168.1.92:/home/udoy/Mar23/'];
system(command);
command=['sshpass -p udoy01717 ssh udoy@192.168.1.92 nohup python /home/udoy/Mar23/modes_python_code_4.py ',tname(6:end-4) ,' ','1',' ',num2str(2)];

'Running python code...'

system(command)

'...Python finished'
command=['pscp -pw udoy01717 udoy@192.168.1.92:/home/udoy/Mar23/Results',tname(6:end-4) '*.mat /media/s/DATA/rand_follo_0/'];

system(command)
%!pscp -pw udoy01717 udoy@192.168.1.92:/home/udoy/Mar23/Results*.mat /home/s/Desktop/rand_follo_0/
data_save(tname(6:end-4),1)
load(['Final_' tname(6:end-4) '.mat'],'intrinsic_1_2','r_intrinsic_1_2',...
    'transfer_entropy_1_2','r_transfer_entropy_1_2','TDMI_1_2','r_TDMI_1_2')
command = ['rm *' tname(6:end-4) '*.mat'];
system(command)