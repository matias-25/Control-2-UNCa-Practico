function [X]=modmotor_2_1b(t_etapa, xant, accion)
Laa=366e-6; J=5e-9;Ra=55.6;B=0;Ki=6.49e-3;Km=6.53e-3;
Va=accion(1);
TL=accion(2);
TLp=2e-4*TL;
h=1e-7;
omega= xant(1);
wp= xant(2);
ia=xant(3); iap=0;
for ii=1:t_etapa/h
    wpp =(-wp*(Ra*J+Laa*B)-omega*(Ra*B+Ki*Km)+Va*Ki-TL*Ra-Laa*TLp)/(J*Laa); 
    iap=-Ra*ia/Laa-Km*omega/Laa+Va/Laa;
    ia=ia+iap*h;    
    wp=wp+h*wpp;
    TL=TL+h*TLp;
    omega = omega + h*wp;
end
X=[omega,wp,ia,TL];
