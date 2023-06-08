function [X]=modmotor_2_3(t_etapa, xant, accion)
%De la funcion de Transferencia obtenida del método de Chen
%wr=(16.52*Va-663.3TL)/(1e-7s^2+4e-4+1) comparando con FT general se puede despejar las constantes 
B=0;%se considera la viscosidad motora nula
Ki=16.52;%const de Va
Ra=663.3;%const de TL
J=(4.e-4)/Ra; %const de wp
Laa=1e-7/J;%const de wpp
Km=1/Ki;
%pasando al dominio del tiempo nos queda wpp=(-4e-4wp-omega+16.52*Va-663.3*TL)/(1e-7)

Va=accion(1);
TL=accion(2);
TLp=0;
h=1e-7;
ia=xant(1);
omega= xant(2);
wp=xant(3);
theta=xant(4);

for ii=1:t_etapa/h
    wpp =(-wp*(Ra*J+Laa*B)-omega*(Ra*B+Ki*Km)+Va*Ki-TL*Ra-Laa*TLp)/(J*Laa); 
    wp=wp+h*wpp;
    iap=(-Ra*ia-Km*omega+Va)/Laa;
    ia=ia+iap*h;
    omega = omega + h*wp;
    thetap=omega;
    theta=theta+thetap*h;
end
X=[ia,omega,wp,theta];