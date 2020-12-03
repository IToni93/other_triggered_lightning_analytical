import matplotlib.pyplot as plt

def subplot_geometry(XL,YL):
    plt.vlines(x= 0, ymin = 0, ymax = 0.5, color='k',linewidth=2,label='Tall structure x=0') 
    plt.xlabel('X (km)')
    plt.ylabel('Y (km)')
    plt.legend()
    plt.xlim(XL)
    plt.ylim(YL)
    plt.title('Geometry')

def subplot_graph(H):
    plt.title('Vertical Electric Field Hmin={:.0f} m'.format(H))
    plt.xlabel('Time (ms)')
    plt.ylabel('Electric Field (kV/m)')
    plt.legend()


def subplot_2D(x,y,z,time,value_min,value_max):
    z = z[:-1, :-1]

    # plt.pcolor(x, y, z*1e-3, cmap='jet', vmin=value_min, vmax=value_max)
    # imshow is much faster than plt.pcolor
    plt.imshow(z*1e-3, cmap ='jet', vmin = value_min, vmax = value_max, 
                 extent =[x.min(), x.max(), y.min(), y.max()], 
                    interpolation ='nearest', origin ='lower',aspect='auto') 
    plt.xlabel('X (km)')
    plt.ylabel('Y (km)')
    plt.axis([x.min(), x.max(), y.min(), y.max()])
    plt.colorbar()
    plt.title('2D Vertical E-Field t={:.2f} ms'.format(time*1e3))

