clear all;clc
num_trials=1;
TMAX_array=[ 1e6];
R=2;
for TMAX_ind=1:length(TMAX_array)
    TMAX=TMAX_array(TMAX_ind);
    
    for trial_ind=1:num_trials
        X=[];Y=[];Z=[];
        [X, Y, Z] = binary_system(TMAX,R);
    end
end

sym_X=X+1;
sym_Y=Y+1;
sym_Z=get_symbol_strings_for_Z(Z,2);
clearvars -except sym_X sym_Y sym_Z

% entropy(sym_X(2:end))
% entropy(sym_Y)
% entropy(sym_Z)
conditional_entropy_x_given_y(sym_X,sym_Y,2)
conditional_entropy_x_given_y(sym_Y,sym_X,2)

conditional_entropy_x_given_y(sym_Y(1:end-1),sym_Y(2:end),2)

conditional_entropy_x_given_y(sym_Y(2:end),sym_X(1:end-1),2)

conditional_entropy_x_given_y(sym_X(1:end-1),sym_Z(1:end),2)
