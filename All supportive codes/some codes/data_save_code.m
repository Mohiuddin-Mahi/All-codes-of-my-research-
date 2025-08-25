
clear all;clc
noise=linspace(0,2*pi,10);
str1='Results_3_birds_noise_';
st='_2_3_';
str2='.mat';
str3='intrinsic_w_';
str4='r_intrinsic_w_';
str5='shared_w_';
str6='r_shared_w_';
str7='synergistic_w_';
str8='r_synergistic_w_';
str9='Transfer_entropy_w_';
str10='r_Transfer_entropy_w_';
str11='TDMI_w_';
str12='r_TDMI_w_';

for ind=1:length(noise)
    load([str1,num2str(ind),st,num2str(ind),str2]);
    
    intrinsic_2_3(ind,:)=eval([str3,num2str(ind)]);
    r_intrinsic_2_3(ind,:)=eval([str4,num2str(ind)]);
    shared_2_3(ind,:)=eval([str5,num2str(ind)]);
    r_shared_2_3(ind,:)=eval([str6,num2str(ind)]);
    synergistic_2_3(ind,:)=eval([str7,num2str(ind)]);
    r_synergistic_2_3(ind,:)=eval([str8,num2str(ind)]);
    transfer_entropy_2_3(ind,:)=eval([str9,num2str(ind)]);
    r_transfer_entropy_2_3(ind,:)=eval([str10,num2str(ind)]);
    TDMI_2_3(ind,:)=eval([str11,num2str(ind)]);
    r_TDMI_2_3(ind,:)=eval([str12,num2str(ind)]);
    
    %intrinsic_2_3(ind,:)=eval([str4,num2str(ind)]);
    clearvars -except  intrinsic_2_3 r_intrinsic_2_3 shared_2_3 r_shared_2_3 synergistic_2_3...
     r_synergistic_2_3 transfer_entropy_2_3 r_transfer_entropy_2_3  TDMI_2_3 r_TDMI_2_3 str1 str2...
 str3 str4 str5 str6 str7 str8 str9 str10 str11 str12 st
    
end
clear str1 str2 str3 str4 str5 str6 str7 str8 str9 str10 str11 str12 st

save('result_2_3.mat')
