
%% Alexander model
%mobility of lightn positive ions
mi=1.5e-4;
e0=8.854187e-12;
%thunde electric field
Eth=10e3;
%waveform
t=0.03
t2=10
%radius of sphere
r0=5e-2;
%height of tower
H=200;
%voltage
Uf=Eth*H;
UM=2e6;
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

A=UM/t(end); 
Ut=A*t.^(k);

A2=UM/t2(end); 
Ut2=A2*t2.^(k);

Rt=((2*mi*Ut.*t)./(3*k+3)).^(0.5);

it=2*pi*e0*Ut.^(1.5).*((k+1)*mi./(6*t)).^(0.5);
it2=2*pi*e0*Ut2.^(1.5).*((k+1)*mi./(6*t2)).^(0.5);
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

E_no_cor=Uf*r0./(r_dis.*r_dis);

RO_r=(r_dis).^(-1.5)*((3*it(end)*e0/(8*pi*mi)).^(0.5));

%RO_r=it(end)*(3*it(end)*e0./(8*pi*mi*r_dis)).^(0.5).*(1./r_dis);

% plot(r_dis,Uwno_corona*1e-6,'k','linewidth',2)
% hold on
% plot(r_dis,U_cor_dis*1e-6,'k--','linewidth',2)
plot(r_dis,E_no_cor*1e-6,'k','linewidth',2)
hold on
plot(r_dis,E_r*1e-6,'k--','linewidth',2)
plot(r_dis,E_r2*1e-6,'k:','linewidth',2)

xlim([r_dis(1) 0.5])
ylim([0 3])

legend('Without corona','With corona \tau = 30 ms','With corona \tau = 10 s');
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




