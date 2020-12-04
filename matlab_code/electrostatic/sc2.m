close all

%% CONST
e0=8.8541878128e-12;
k=1/(4*pi*e0);

%% INPUT
lamn=-0.5e-3;
xp=0;
yp=0;
v1=-2e4;
v2=1e5;
y=2e3; % initial altitude of leader
xx=-2e3; % distance of the leader

x0=-3e3;
lamp=-abs(v2/v1)*lamn;

TD=10e-3;
%% TIME
t1=0:0.1e-3:TD;
t2=TD+0.1e-3:0.1e-3:60e-3
t=[t1 t2];   %5ms po km sa svake strane

x2=x0+v2*t;

x1=x0+v1*t1;

y2=y+v1*(t2-TD);



%% prototip    electric_f2(k,lam,y,x1,x2,xp,yp)

%lam=1e5;
%[Ex Ey]=electric_f2(k,-lam,1e3,0,1e-5,1e3,1e3);

%% negative
% real
[Exr Eyr]=electric_f2(k,lamn,y,x0,x2,xp,yp);
%% image
[Exi Eyi]=electric_f2(k,-lamn,-y,x0,x2,xp,yp);

Enx=Exr+Exi;
Eny=Eyr+Eyi;

%% positive
%% HORIZONTAL

%% positive
% real
[Exr Eyr]=electric_f2(k,lamp,y,x1,x0,xp,yp);
%% image
[Exi Eyi]=electric_f2(k,-lamp,-y,x1,x0,xp,yp);
Epx1=Exr+Exi;
Epy1=Eyr+Eyi;

%% VERTICAL
% real
[Eyr2 Exr2]=electric_f2(k,lamp,x1(end),y2,y,yp,xp);
% %% image
[Eyi2 Exi2]=electric_f2(k,-lamp,x1(end),-(y),-(y2),yp,xp);

Epx2=Exr2+Exi2;
Epy2=Eyr2+Eyi2;

Epx=[Epx1 Epx2+Epx1(end)];
Epy=[Epy1 Epy2+Epy1(end)];







% plot(t*1e3,Eny*1e-3,'k--','linewidth',2)
% 
% 
% hold on
plot(t*1e3,Epy*1e-3,'k','linewidth',2)

% plot(t*1e3,(Eny+Epy)*1e-3,'k','linewidth',2)

% legend('Negative Leader','Positive Leader','Total Electric Field')
% title('Horizontal Leader Electric Field y''=1km')
% title('In-cloud Leader Electric Field')
xlabel('Time (ms)');
ylabel('Electric Field (kV/m)');



plot(t*1e3,Eny*1e-3,'k--','linewidth',2)
xlabel('Time (ms)');
ylabel('Electric Field (kV/m)');

hold on
plot(t*1e3,Epy*1e-3,'k:','linewidth',2)

plot(t*1e3,(Eny+Epy)*1e-3,'k','linewidth',2)

legend('Negative Leader','Positive Leader','Total Electric Field')
title('Horizontal Leader Electric Field y''=1km')
title('In-cloud Leader - Propagation to Ground')