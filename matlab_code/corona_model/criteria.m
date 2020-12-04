close all
mi=1.5e-4;
e0=8.854187e-12;
Ec=3e6;
r0=0.7e-2;
delta=3e-4;
tau=1e-3:delta:60e-3+delta;
%tau=tau*1e-3

k=2*Ec*(6*mi*Ec).^(1/3)
Um=k*r0^(2/3)*(tau).^(1/3);

r0=2e-2;
Um11=k*r0^(2/3)*(tau).^(1/3);

r0=5e-2;
Um111=k*r0^(2/3)*(tau).^(1/3);

r0=0.2e-2;
Um1111=k*r0^(2/3)*(tau).^(1/3);

Um2=1e6*1.86*tau.^(1/3);


Um3=1e6*3.54*tau.^(5/16);

%tau=tau*1e3
figure(1)
plot(tau*1e3,Um*1e-6,'k','linewidth',2)
hold on

set(gca,'FontSize',14)

ylabel('Voltage MV)');
xlabel('Risetime (ms)');
title('Criteria');


plot(tau*1e3,Um2*1e-6,'k:','linewidth',2)
plot(tau*1e3,Um3*1e-6,'k--','linewidth',2)
plot(tau*1e3,Um11*1e-6,'k','linewidth',2)
plot(tau*1e3,Um111*1e-6,'k','linewidth',2)
plot(tau*1e3,Um1111*1e-6,'k','linewidth',2)
 legend('Streamer Criterion','Leader Criterion','Vital Leader Criterion');
xlim([tau(1) tau(end)]*1e3)