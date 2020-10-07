%% CONST
e0=8.8541878128e-12;
k=1/(4*pi*e0);

%% INPUT
lamn=-0.5e-3;
xp=0;
yp=0;
v1=-2e4;
v2=1e5;
y=2e3; 
x0=-3e3;
lamp=-abs(v2/v1)*lamn;

%% TIME
t=0:0.1e-3:60e-3;   %5ms po km sa svake strane
x2=x0+v2*t;
x1=x0+v1*t;


%% negative leader
% real
[Exr Eyr]=electric_f2(k,lamn,y,x0,x2,xp,yp);
% image
[Exi Eyi]=electric_f2(k,-lamn,-y,x0,x2,xp,yp);

%total negative
Enx=Exr+Exi;
Eny=Eyr+Eyi;

%% positive leader
% real
[Exr Eyr]=electric_f2(k,lamp,y,x1,x0,xp,yp);
% image
[Exi Eyi]=electric_f2(k,-lamp,-y,x1,x0,xp,yp);

%total positive
Epx=Exr+Exi;
Epy=Eyr+Eyi;


%% PLOT
plot(t*1e3,Eny*1e-3,'k--','linewidth',2)
xlabel('Time (ms)');
ylabel('Electric Field (kV/m)');
hold on
plot(t*1e3,Epy*1e-3,'k:','linewidth',2)
plot(t*1e3,(Eny+Epy)*1e-3,'k','linewidth',2)

legend('Negative Leader','Positive Leader','Total Electric Field')
title('Horizontal Leader Electric Field y''=1km')
title('In-cloud Leader Vertical Electric Field')


