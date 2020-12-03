import numpy as np
import math

def e_field_horizontal_leader(lam,y,x1,x2,xp,yp):
    
    # lam - line charge density
    # y - altitude
    # x1 - starting position
    # x2 - ending position
    # xp,yp - observation point

    e0=8.8541878128e-12
    k=1/(4*math.pi*e0)

    R1=np.sqrt((xp-x1)**2+(yp-y)**2)
    R2=np.sqrt((xp-x2)**2+(yp-y)**2)
    
    # Horizontal leader Ex for the record if needed, not used here in simulations
    # Ex=k*lam*(1.0/R2-1.0/R1)
    # Horizontal leader Ey
    Ey=k*lam*(yp-y)*(1.0/(R2*(xp-x2+R2))-1.0/(R1*(xp-x1+R1)))
    
    # Avoid undefined limit when (yp-y)==0 
    Ey[Ey==np.inf]=0
    return Ey

def e_field_vertical_leader(lam,x,y2,y,xp,yp):
   
    ''' Field from Vertical leader could be obtain using the formula for horizontal leader
     and some substitutions (see matlab solution), however for the sake of readability we 
     write these two formulas separately here.
    '''

    # lam - line charge density
    # x - location of vertical leader
    # y2 - current location of tip
    # y - initiation altitude
    # xp,yp - observation point

    e0=8.8541878128e-12
    k=1/(4*math.pi*e0)

    R1=np.sqrt((yp-y2)**2+(xp-x)**2)
    R2=np.sqrt((yp-y)**2+(xp-x)**2)
    
    # Vertical leader Ey 
    Ey=k*lam*(1.0/R2-1.0/R1)
    
    # Vertical leader Ex for the record if needed, not used here in simulations
    #Ex=k*lam*(yp-y)*(1.0/(R2*(xp-x2+R2))-1.0/(R1*(xp-x1+R1)))
    
    # Avoid undefined limit now for Ex field 
    #Ex[Ex==np.inf]=0

    return Ey


def total_e_field_horizontal_leader(lam,y,x0,x2,xp,yp):
    # Real source + Image source
    Ey=e_field_horizontal_leader(lam,y,x0,x2,xp,yp)+e_field_horizontal_leader(-lam,-y,x0,x2,xp,yp)
    return Ey

def total_e_field_vertical_leader(lam,x1,y2,y,xp,yp):
    # Real source + Image source
    Ey=e_field_vertical_leader(lam,x1,y2,y,xp,yp)+e_field_vertical_leader(-lam,x1,-(y),-(y2),xp,yp)
    return Ey
