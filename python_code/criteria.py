import numpy as np

def minimum_height(waveform,step):
    mx=np.amax(waveform)
    ind=np.argmin((np.abs(waveform-0.1*mx)))
    ind2=np.argmin((np.abs(waveform-0.9*mx)))
    RT=(ind2-ind)*step

    # 80% of maximum electric field
    A=mx*0.8

    # Sustained leader criteria (check the paper)
    U=1e6*3.54*RT**(5/16)
    # Minimum height to satisfy 
	# Assuming that electric field is constant along the tower, in case of taller structures it should be numerically integrated
    h=U/A
    return h





