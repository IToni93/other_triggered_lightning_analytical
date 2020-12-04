function [Ex Ey]= electric_f2(k,lam,y,x1,x2,xp,yp)

% lam - line charge density
% y - altitude
% x1 - starting position
% x2 - ending position
% xp,yp - observation point

R1=sqrt((xp-x1).^2+(yp-y).^2);
R2=sqrt((xp-x2).^2+(yp-y).^2);

Ex=k*lam*(1./R2-1./R1);

%for limit
    if (yp-y)==0
        Ey=0;
    else
    Ey=k*lam*(yp-y)*(1./(R2.*(xp-x2+R2))-1./(R1.*(xp-x1+R1)));
    end
end

