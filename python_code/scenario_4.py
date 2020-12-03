import numpy as np
import matplotlib.pyplot as plt
import math

from . import criteria
from . import plotter
from .electrostatic import total_e_field_horizontal_leader


def sc_4(lamn=-0.5e-3,y=2e3,xp=0.0,yp=0.0,x0=-3e3,v2=1e5,duration=None,st=None,step_2d=0.03,t_2d_coef=1):

    ## INPUT
    if duration==None:
        duration=abs(x0/v2)*2

    if st==None:
        st=duration/1000

    # TIME
    t=np.arange(start=0.0, stop=duration+st, step=st)

    # Time evolution of geometrical coordinates
    x2=x0+v2*t


    ###  FIELD AS FUNCTION OF TIME AT ORIGIN (0,0) ###
    Eny=total_e_field_horizontal_leader(lamn,y,x0,x2,xp,yp)
    H=criteria.minimum_height(Eny,st)

    # Adopt the y range to case
    coef=1
    if y*1e-3<5:
        coef=2

    # Limits of 2D domain
    XL=[-x2[-1]*2e-3,x2[-1]*2e-3]
    YL=[0,11/coef]

    ### 2D ELECTRIC FIELD ###

    # Get time 
    time_index_2d=round(t_2d_coef*duration/st)
    time_2d=t[time_index_2d]

    # Mesh grid
    xp2,yp2 = np.mgrid[slice(XL[0], XL[1] + step_2d, step_2d),
                    slice(YL[0]+1e-2,YL[1] + step_2d, step_2d)]
    # Calculate 2D
    zp2=total_e_field_horizontal_leader(lamn,y,x0,x2[time_index_2d],xp2*1e3,yp2*1e3)
    zp2=np.transpose(zp2)

    ### PLOT ###

    plt.figure(figsize=(16,4), dpi= 100, facecolor='w', edgecolor='k')

    ## SUBPLOT 1 ##
    plt.subplot(1,3,1)
    # Leaders
    plt.hlines(y = y*1e-3, xmin = x0*1e-3, xmax = x2[-1]*1e-3,color='b',linewidth=1+4*abs(lamn*1e3),label='Negative Leader')
    # Graph template
    plotter.subplot_geometry(XL,YL)

    ## SUBPLOT 2 ##
    plt.subplot(1,3,2)
    # Plot line graphs
    plt.plot(t*1e3,(Eny)*1e-3,'k',linewidth=2,label='Total Electric Field')
    # Graph template
    plotter.subplot_graph(H)

    ## SUBPLOT 3 ##
    plt.subplot(1,3,3)
    # Graph template
    plotter.subplot_2D(x=xp2,y=yp2,z=zp2,time=time_2d,value_min=-75,value_max=75)

def main():
    ## If you want to run as script delete relative import "from .""
    sc_4()
    plt.show()
    
if __name__ == "__main__":
    main()


