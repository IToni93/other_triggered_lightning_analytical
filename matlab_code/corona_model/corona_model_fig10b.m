close all
%% Alexander model
%mobility of lightn positive ions
mi=1.5e-4;
e0=8.854187e-12;
%thunde electric field
Eth=10e3;
%waveform
t=0:1e-4:2e-3;
t1=30e-3;
t2=30e-3;

t3=30e-6;
t4=30e-6;

%radius of sphere
r0=5e-2;
%height of tower
H=200;
%voltage
Uf=Eth*H;

%% STATIC
Uf=2e6;
%radial coordinate
r=r0:1e-2:100*r0;

%% waveform
k=1;
A=200e5;  
Ut=A*t.^(k);


%% plot fig2 STATIONARY CORONA
%electric ptential without corona

Uno_corona=Uf*r0./(r);
R=500*r0;
tt=R^2*3*(k+1)/(2*mi*Uf)

itt=2*pi*e0*Uf.^(1.5).*((k+1)*mi./(6*tt)).^(0.5);
EEEEEEE=sqrt(itt/(6*pi*e0*mi*R));


U_corona_r=3*EEEEEEE*R*(1-(2/3)*(r/R).^(0.5));
U_corona_r(1)
plot(r/r0,Uno_corona/Uf,'linewidth',2)
hold on
plot(r/r0,U_corona_r/U_corona_r(1),'linewidth',2)
legend('Electric field without Corona effects')

k=1;

%% plot fig3 NON-STATIONARY CORONA
figure(3)
A=4e5;  
Ut=A*t.^(k);
Rt=((2*mi*Ut.*t)./(3*k+3)).^(0.5);
it=2*pi*e0*Ut.^(1.5).*((k+1)*mi./(6*t)).^(0.5);

plot(t,it,'linewidth',2);
ylabel('Current (mA)');
xlabel('Time (s)');
legend('I(mA)')

%% plot fig4 RADIAL_DISTRIBTION
figure(4)

UM=4e6;
A1=UM/t1(end); 
Ut1=A1*t1.^(k);

UM=2e6;
A2=UM/t2(end); 
Ut2=A2*t2.^(k);

UM=0.5e6;

A3=UM/t3(end); 
Ut3=A3*t3.^(k);

UM=0.3e6;
A4=UM/t4(end); 
Ut4=A4*t4.^(k);



Rt=((2*mi*Ut.*t)./(3*k+3)).^(0.5);
it=2*pi*e0*Ut1.^(1.5).*((k+1)*mi./(6*t1)).^(0.5);

it2=2*pi*e0*Ut2.^(1.5).*((k+1)*mi./(6*t2)).^(0.5);

it3=2*pi*e0*Ut3.^(1.5).*((k+1)*mi./(6*t3)).^(0.5);

it4=2*pi*e0*Ut4.^(1.5).*((k+1)*mi./(6*t4)).^(0.5);


III=it(end)
Rend=Rt(end);
% eq 7-9  dovoljne iznad nekih 20cm inace 5 i 6
r_dis=0.05:0.001:0.5;

% at REND
E_R=sqrt(it(end)/(6*pi*e0*mi*Rend));

U_cor_dis=3*E_R*Rend*(1-(2/3)*(r_dis/Rend).^(0.5));
Uno_corona=Uf*r0./(r_dis);

E_r=(it(end)./(6*pi*e0*mi*r_dis)).^(0.5);

Ec=3e6;

E_r=(1./r_dis.^2).*(Ec^2*r0^4+it(end)*(r_dis.^3-r0^3)./(6*pi*e0*mi)).^(0.5);
E_r2=(1./r_dis.^2).*(Ec^2*r0^4+it2(end)*(r_dis.^3-r0^3)./(6*pi*e0*mi)).^(0.5);

E_r3=(1./r_dis.^2).*(Ec^2*r0^4+it3(end)*(r_dis.^3-r0^3)./(6*pi*e0*mi)).^(0.5);
E_r4=(1./r_dis.^2).*(Ec^2*r0^4+it4(end)*(r_dis.^3-r0^3)./(6*pi*e0*mi)).^(0.5);


E_no_cor=Uf*r0./(r_dis.*r_dis);

RO_r=(r_dis).^(-1.5)*((3*it(end)*e0/(8*pi*mi)).^(0.5));

plot(r_dis,E_r*1e-6,'k','linewidth',2)
hold on
plot(r_dis,E_r2*1e-6,'k','linewidth',2)
plot(r_dis,E_r3*1e-6,'k','linewidth',2)
plot(r_dis,E_r4*1e-6,'k','linewidth',2)


xlim([r_dis(1) 0.5])
%ylim([0 3])

%legend('RT=30ms Um=200MV','RT=30ms Um=200MV','RT=30us Um=200MV','RT=30us Um=200MV');
% 
ylabel('Electric field (MV/m)');
title('Radial Distribution of Electric Field');
set(gca,'FontSize',14)
% yyaxis right
% plot(r_dis,RO_r,'linewidth',2)
%plot(r_dis,E_r,'linewidth',2)
%ylim([0 1e-12]);

%ylabel('Electric Field (V/m)');

xlabel('r (m)');

% some parameters

vf=mi*E_R;
k=sqrt(3*it(end)*e0/(8*pi*mi));
%Q0=4*pi*k*(2/3)*(Rend^(1.5)-(1)^(1.5))
%Q1=4*pi*e0*r0^2*3e6


1.5*((400e3)^4*1.5e-4/(2*1))^(1/3)

