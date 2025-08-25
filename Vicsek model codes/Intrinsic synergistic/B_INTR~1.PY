from scipy.io import loadmat,savemat

import dit
import time
import numpy as np
from dit.inference import binned, dist_from_timeseries
from dit.multivariate import total_correlation as I, intrinsic_total_correlation as IMI

from multiprocessing import Pool, freeze_support
n_jobs = 18


def calc1(arg):


    symbol, j, k, bird1_ind,bird2_ind= arg
    mystr2=str(k);
    a=np.array(symbol['symbols'][0][j][bird1_ind])
    b=np.array(symbol['symbols'][0][j][bird2_ind])
    array=np.vstack([a, b]).T
    time_series_distribution = dist_from_timeseries(array, history_length=1)
    time_series_distribution.set_rv_names(['X','Y','Z','T'])                   #X=x_t;Y=y_t;Z=x_(t+1);T=y_(t+1)
    intrinsic_x_to_y= IMI(time_series_distribution, ['X', 'T'], 'Y')
    time_delayed_mutual_information_x_to_y= I(time_series_distribution, ['X', 'T'])
    transfer_entropy_x_to_y= I(time_series_distribution, ['X', 'T'], 'Y')
    shared_x_to_y= time_delayed_mutual_information_x_to_y - intrinsic_x_to_y
    synergistic_x_to_y= transfer_entropy_x_to_y - intrinsic_x_to_y
    
    return intrinsic_x_to_y, transfer_entropy_x_to_y, shared_x_to_y, synergistic_x_to_y, time_delayed_mutual_information_x_to_y
    

def calc2(arg):

 

    symbol, j,k,bird1_ind,bird2_ind= arg
    mystr1=str(k);
    a=np.array(symbol['symbols'][0][j][bird2_ind])
    b=np.array(symbol['symbols'][0][j][bird1_ind])
    array=np.vstack([a, b]).T
    time_series_distribution = dist_from_timeseries(array, history_length=1)
    time_series_distribution.set_rv_names(['X','Y','Z','T'])                #X=x_t;Y=y_t;Z=x_(t+1);T=y_(t+1)
    intrinsic_x_to_y= IMI(time_series_distribution, ['X', 'T'], 'Y')
    time_delayed_mutual_information_x_to_y= I(time_series_distribution, ['X', 'T'])
    transfer_entropy_x_to_y= I(time_series_distribution, ['X', 'T'], 'Y')
    shared_x_to_y= time_delayed_mutual_information_x_to_y - intrinsic_x_to_y
    synergistic_x_to_y= transfer_entropy_x_to_y - intrinsic_x_to_y
    
    return intrinsic_x_to_y, transfer_entropy_x_to_y, shared_x_to_y, synergistic_x_to_y, time_delayed_mutual_information_x_to_y


def main():
    num_noise =40;
    leader_weight_list=[1,10,100,1000,10000,100000];
    nbird=3;
    
    for weight_ind in leader_weight_list:
        for file_ind in range(1,num_noise+1):
            for bird1_ind in range(0,nbird):
                for bird2_ind in range(bird1_ind+1, nbird):
                    my_str1=str(file_ind)+'.mat'
                    my_str2=str(file_ind)
                
                    symbol=loadmat("symbols_weight_"+str(weight_ind)+"_noise_"+my_str1)
                    row_num=np.shape(symbol["symbols"])[0]
                    col_num=np.shape(symbol["symbols"])[1]
                    with Pool(n_jobs) as p:
                        args = [(symbol, j,file_ind,bird1_ind,bird2_ind) for j in range(col_num)]
                        res = p.map(calc1, args)
                    
                    res = np.array(res).reshape(row_num, col_num, 5)
                    intrinsic = res[:, :, 0]
                    TDMI = res[:, :, 4]
                    TE = res[:, :, 1]
                    shared = res[:, :, 2]
                    synergistic = res[:, :, 3]
                
                    with Pool(n_jobs) as p:
                        args = [(symbol, j,file_ind,bird1_ind,bird2_ind) for j in range(col_num)]
                        res = p.map(calc2, args)
                    
                    res = np.array(res).reshape(row_num, col_num, 5)
                    intrinsic_1 = res[:, :, 0]
                    TDMI_1 = res[:, :, 4]
                    TE_1 = res[:, :, 1]
                    shared_1 = res[:, :, 2]
                    synergistic_1 = res[:, :, 3]
            
                    savemat("results_weight_"+str(weight_ind)+"_noise_"+str(file_ind)+"_"+str(bird1_ind+1)+"_"+str(bird2_ind+1)+"_" +my_str1,{"intrinsic_"+my_str2:intrinsic,"synergistic_"+my_str2:synergistic,"Transfer_entropy_"+my_str2:TE,"shared_"+my_str2:shared,"TDMI_"+my_str2:TDMI,"r_intrinsic_"+my_str2:intrinsic_1,"r_synergistic_"+my_str2:synergistic_1,"r_Transfer_entropy_"+my_str2:TE_1,"r_shared_"+my_str2:shared_1,"r_TDMI_"+my_str2:TDMI_1})

if __name__ == "__main__":                    # intrinsic_w means 1st bird to 2nd bird interaction and r_intrinsic_w means 2nd bird to 1st bird interaction, same thing for others.
    freeze_support()
    main()

