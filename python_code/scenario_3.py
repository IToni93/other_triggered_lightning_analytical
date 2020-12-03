import numpy as np
import matplotlib.pyplot as plt
import math

from .electrostatic import total_e_field_horizontal_leader,total_e_field_vertical_leader
from . import criteria
from . import plotter


def sc_3(lamp=2.5e-3,y=2e3,xp=0.0,yp=0.0,x0=0e3,xrs=-1e3,vrs=0.9e8,duration=None,st=None,step_2d=0.03,t_2d_coef=1):


    if duration==None:
        duration=(y+abs(x0-xrs))/vrs

    if st==None:
        st=duration/1000
    # Positice charge deposited along the channel is neutralized with return stroke of negative line charge density
    lamn=-lamp
    
    # Time 
    t=np.arange(start=0.0, stop=duration+st, step=st)
    # Get index when return stroke reaches top altitude
    TD=y/vrs
    ind_TD=np.argmin((np.abs(t-TD)))
    # Get 2D time index
    time_index_2d=round(t_2d_coef*duration/st)
    time_2d=t[time_index_2d]

    # Time evolution of geometrical coordinates
    y2=vrs*(t[0:ind_TD+1])
    x2=xrs+vrs*(t[ind_TD+1:]-TD)*np.sign(x0-xrs) 


    ###  FIELD AS FUNCTION OF TIME AT ORIGIN (0,0) ###
    Epy=sc_3_field_vs_time(lamn,y2,xrs,x2,xp,yp,ind_TD,len(t)-1)
    H=criteria.minimum_height(Epy,st)

    # Adopt the y range to case
    coef=1
    if y*1e-3<5:
        coef=2

    # Limits of 2D domain
    XL=[-abs(xrs)*2e-3,abs(xrs)*2e-3]
    YL=[0,11/coef]

    ### 2D ELECTRIC FIELD ###

    # Mesh grid
    xp2,yp2 = np.mgrid[slice(XL[0], XL[1] + step_2d, step_2d),
                    slice(YL[0]+1e-2,YL[1] + step_2d, step_2d)]
    # Calculate 2D
    zp2=sc_3_field_2d(lamn,y2,xrs,x2,xp2*1e3,yp2*1e3,ind_TD,time_index_2d)
    zp2=np.transpose(zp2)

    ### PLOT ###

    plt.figure(figsize=(16,4), dpi= 100, facecolor='w', edgecolor='k')
    ## SUBPLOT 1 ##
    plt.subplot(1,3,1)

    # Geometry
    plt.vlines(x = xrs*1e-3, ymin = 0, ymax = y2[-1]*1e-3,color='b',linewidth=1+abs(lamp*1e3),label='Charge Deposited by RS') 
    if x2.size>0:
        plt.hlines(y = y*1e-3, xmin = xrs*1e-3, xmax = x0*1e-3,color='b',linewidth=1+abs(lamp*1e3))
    
    # Graph template
    plotter.subplot_geometry(XL,YL)

    ## SUBPLOT 2 ##
    plt.subplot(1,3,2)
    # Plot line graphs
    plt.plot(t*1e6,(Epy)*1e-3,'k',linewidth=2,label='Total Electric Field')
    # Graph template
    plotter.subplot_graph(H)
    # Correct time label
    plt.xlabel('Time ($\mu$s)')

    ## SUBPLOT 3 ##
    plt.subplot(1,3,3)
    # Graph template
    plotter.subplot_2D(x=xp2,y=yp2,z=zp2,time=time_2d,value_min=-50,value_max=50)
    # Correct time label
    plt.title('2D Vertical E-Field t={:.2f} $\mu$s'.format(time_2d*1e6))

def sc_3_field_vs_time(lamn,y2,xrs,x2,xp,yp,ind_TD,ind_t_max):

    # Initialize
    Epy=np.empty(ind_t_max+1)
    # Positive leader before it veer toward the ground
    Epy[0:ind_TD+1]=total_e_field_vertical_leader(lamn,xrs,y2[0],y2,xp,yp)  
    # Electric field of positive leader before + after it veer toward the ground (sign for change of limits x limits should go from left to right)
    Epy[ind_TD+1:ind_t_max+1]=Epy[ind_TD]+total_e_field_horizontal_leader(lamn,y2[-1],xrs,x2,xp,yp)*np.sign(x2[-1]-xrs)                  
    return Epy


def sc_3_field_2d(lamn,y2,xrs,x2,xp,yp,ind_TD,ind_t):

    if ind_t<=ind_TD:
        # Positive leader before it veer toward the ground
        Epy=total_e_field_vertical_leader(lamn,xrs,y2[0],y2[ind_t],xp,yp)  
    else:
        # Electric field of positive leader before + after it veer toward the 
        Epy=total_e_field_vertical_leader(lamn,xrs,y2[0],y2[ind_TD],xp,yp)+total_e_field_horizontal_leader(lamn,y2[ind_TD],xrs,x2[ind_t-ind_TD-1],xp,yp)*np.sign(x2[ind_t-ind_TD-1]-xrs)  
        
    return Epy

def main():
    ## If you want to run as script delete relative import "from .""
    sc_3()
    plt.show()
    

if __name__ == "__main__":
    main()


