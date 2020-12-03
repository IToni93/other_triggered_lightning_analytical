import numpy as np
import matplotlib.pyplot as plt
import math

from .electrostatic import total_e_field_horizontal_leader,total_e_field_vertical_leader
from . import criteria
from . import plotter


def sc_2(lamn=-0.5e-3,y=2e3,xp=0.0,yp=0.0,x0=-3e3,v1=-2e4,v2=1e5,lamp=None,duration=None,st=None,step_2d=0.03,t_2d_coef=1,TD_coef=1/6):

    ## INPUT
    if lamp==None:
        lamp=-abs(v2/v1)*lamn

    if duration==None:
        duration=abs(x0/v2)*2
        if duration>(abs(v1)/y):
            duration=abs(v1)/(y*1.05)

    if st==None:
        st=duration/1000
    
    # Time 
    t=np.arange(start=0.0, stop=duration+st, step=st)
    # Get index when positive leader veer
    TD=TD_coef*duration
    ind_TD=np.argmin((np.abs(t-TD)))
    # Get 2D time index
    time_index_2d=round(t_2d_coef*duration/st)
    time_2d=t[time_index_2d]

    # Time evolution of geometrical coordinates
    y2=y+v1*(t[ind_TD+1:]-TD)
    x2=x0+v2*t
    x1=x0+v1*t[0:ind_TD+1]

    ###  FIELD AS FUNCTION OF TIME AT ORIGIN (0,0) ###
    Eny,Epy=sc_2_field_vs_time(lamn,y,y2,x0,x2,xp,yp,x1,lamp,ind_TD,len(t)-1)
    H=criteria.minimum_height(Eny+Epy,st)

    # Adopt the y range to case
    coef=1
    if y*1e-3<5:
        coef=2

    # Limits of 2D domain
    XL=[-x2[-1]*2e-3,x2[-1]*2e-3]
    YL=[0,11/coef]

    ### 2D ELECTRIC FIELD ###

    # Mesh grid
    xp2,yp2 = np.mgrid[slice(XL[0], XL[1] + step_2d, step_2d),
                    slice(YL[0]+1e-2,YL[1] + step_2d, step_2d)]
    # Calculate 2D
    Eny2,Epy2=sc_2_field_2d(lamn,y,y2,x0,x2[time_index_2d],xp2*1e3,yp2*1e3,x1,lamp,ind_TD,time_index_2d)
    zp2=(Epy2+Eny2)
    zp2=np.transpose(zp2)

    ### PLOT ###

    plt.figure(figsize=(16,4), dpi= 100, facecolor='w', edgecolor='k')
    ## SUBPLOT 1 ##
    plt.subplot(1,3,1)

    # Leaders
    plt.hlines(y = y*1e-3, xmin = x0*1e-3, xmax = x2[-1]*1e-3,color='b',linewidth=1+4*abs(lamn*1e3),label='Negative Leader')
    plt.hlines(y = y*1e-3, xmin = x1[-1]*1e-3, xmax = x0*1e-3,color='r',linewidth=1+4*abs(lamn*1e3),label='Positive Leader') 
    if y2.size>0:
        plt.vlines(x = x1[-1]*1e-3, ymin = y2[-1]*1e-3, ymax = y*1e-3,color='r',linewidth=1+4*abs(lamn*1e3)) 
    
    # Graph template
    plotter.subplot_geometry(XL,YL)

    ## SUBPLOT 2 ##
    plt.subplot(1,3,2)
    # Plot line graphs
    plt.plot(t*1e3,Eny*1e-3,'k--',linewidth=2,label='Negative Leader')
    plt.plot(t*1e3,Epy*1e-3,'k:',linewidth=2,label='Positive Leader')
    plt.plot(t*1e3,(Eny+Epy)*1e-3,'k',linewidth=2,label='Total Electric Field')
    # Graph template
    plotter.subplot_graph(H)

    ## SUBPLOT 3 ##
    plt.subplot(1,3,3)
    # Graph template
    plotter.subplot_2D(x=xp2,y=yp2,z=zp2,time=time_2d,value_min=-100,value_max=100)

def sc_2_field_vs_time(lamn,y,y2,x0,x2,xp,yp,x1,lamp,ind_TD,ind_t_max):

    # Negative leader for whole duration
    Eny=total_e_field_horizontal_leader(lamn,y,x0,x2,xp,yp)
    Epy=np.empty(ind_t_max+1)
    # Positive leader before it veer toward the ground
    Epy[0:ind_TD+1]=total_e_field_horizontal_leader(lamp,y,x1,x0,xp,yp)

    # Electric field of positive leader before + after it veer toward the ground
    Epy[ind_TD+1:ind_t_max+1]=Epy[ind_TD]+total_e_field_vertical_leader(lamp,x1[ind_TD],y2,y,xp,yp)                    
    return Eny,Epy


def sc_2_field_2d(lamn,y,y2,x0,x2,xp,yp,x1,lamp,ind_TD,ind_t):
    # Negative leader for whole duration
    Eny=total_e_field_horizontal_leader(lamn,y,x0,x2,xp,yp)
    if ind_t<=ind_TD:
        # Positive leader before it veer toward the ground
        Epy=total_e_field_horizontal_leader(lamp,y,x1[ind_t],x0,xp,yp)
    else:
        # Electric field of positive leader before + after it veer toward the ground
        Epy=total_e_field_horizontal_leader(lamp,y,x1[ind_TD],x0,xp,yp)+total_e_field_vertical_leader(lamp,x1[ind_TD],y2[ind_t-ind_TD-1],y,xp,yp) 
    return Eny,Epy

def main():
    ## If you want to run as script delete relative import "from .""
    sc_2()
    plt.show()
    

if __name__ == "__main__":
    main()


