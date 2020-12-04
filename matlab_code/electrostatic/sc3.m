clear all
%% CONST
e0=8.8541878128e-12;
k=1/(4*pi*e0);

%% INPUT

xp=0;
yp=0;
vrs=0.9e8;


H=2e3;% initial altitude of leader
xRS=-3e3;
x0=-2e3;



lamp=2.5e-3;
TFINAL=H/vrs;
TFINAL2=(x0-xRS)/vrs;

t1=0:1e-8:TFINAL;
t2=1e-8+TFINAL:1e-8:(TFINAL+TFINAL2)

t=[t1 t2];
%%y2=y+v1*(t2-TD);
y=vrs*t1; %%curent altitude of RS
x2=xRS+vrs*(t2-TFINAL)


%% VERTICAL

%%negative
% real
[Eyr2 Exr2]=electric_f2(k,-lamp,xRS,0,y,yp,xp);
% %% image
[Eyi2 Exi2]=electric_f2(k,lamp,xRS,-(y),-(0),yp,xp);
Epx1=Exr2+Exi2;
Epy1=Eyr2+Eyi2;


%% HORIZONTAL
%% negative
% real
[Exr Eyr]=electric_f2(k,-lamp,H,xRS,x2,xp,yp);
%% image
[Exi Eyi]=electric_f2(k,lamp,-H,xRS,x2,xp,yp);

Epx2=Exr+Exi;
Epy2=Eyr+Eyi;


Epx=[Epx1 Epx2+Epx1(end)];
Epy=[Epy1 Epy2+Epy1(end)];
% plot(t*1e3,Eny*1e-3,'k--','linewidth',2)
% 
% 
% hold on
plot(t*1e6,Epy*1e-3*10,'k','linewidth',2)
hold on
xlabel('Time (\mus)');
ylabel('Electric Field (kV/m)');


title('RS phase')

E=Epy;
mx=max(E);

[val ind]=min(abs(E-0.1*mx))
[val ind2]=min(abs(E-0.9*mx))

g10=t(ind)
g90=t(ind2)

RT=g90-g10
MAX=E(end)
set(gca,'FontSize',14)

xlim([0 100])
ylim([0 35])