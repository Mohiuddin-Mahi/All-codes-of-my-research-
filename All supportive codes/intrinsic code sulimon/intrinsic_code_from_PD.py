from scipy.io import loadmat,savemat
import sys
import dit
import time
import numpy as np
from dit.inference import binned, dist_from_timeseries
from dit.multivariate import total_correlation as I, intrinsic_total_correlation as IMI

from multiprocessing import Pool, freeze_support
events = [
    (0, 0, 0),
    (0, 1, 0),
    (1, 0, 0),
    (1, 1, 0),
    (0, 0, 1),
    (0, 1, 1),
    (1, 0, 1),
    (1, 1, 1),
]
#probs=[0.1667,0.1667,0,0.3333,0.3333,0,0,0]
 
#probs = [1/6,1/6,0,1/6,2/6,0,1/6,0]
probs=[0.166666666666667,0.166666666666667,0,0.166666666666667,0.333333333333333,0,0.166666666666667,0]

#probs=[float(sys.argv[1]),float(sys.argv[2]),float(sys.argv[3]),float(sys.argv[4]),float(sys.argv[5]),float(sys.argv[6]),float(sys.argv[7]),float(sys.argv[8])]
#file_str=str(sys.argv[9])
d = dit.Distribution(events, probs)
 
d.set_rv_names(['X','Y','T'])

imi= IMI(d, ['X', 'T'], 'Y')
TDMI= I(d, ['X', 'T'])
TE= I(d, ['X', 'T'], 'Y')
sigma= TDMI - imi
S= TE - imi

print(imi)
print(TE)
print(S)
#print(file_str)
#savemat("/home/s/Desktop/intrinsic_for_firing_data/Results/" + file_str,{"imi":imi,"TDMI":TDMI,"TE":TE,"sigma":sigma,"S":S})
