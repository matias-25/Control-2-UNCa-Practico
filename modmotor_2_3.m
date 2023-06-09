function [X]=modmotor_2_3(t_etapa, xant, accion)
%De la funcion de Transferencia obtenida del método de Chen
%wr=(0.0008673 s + 16.52)*Va/(2.017e-08 s^2 + 0.0004693 s + 1) 
%wr=(1.596 s + 2024)*TL/(3.016e-07 s^2 + 0.001236 s + 1) 
%se supone que los denominadores de wr/Va y wr/TL son iguales entonces se
%promedian las constantes entonces se obtiene wr=(16.52*Va-(1.596 s + 2024)*TL)/(1.609e-07 s^2 + 8.525e-4 s + 1)
%comparando con FT general se puede despejar las constantes 
B=0;%se considera la viscosidad motora nula
Ki=16.52;%const de Va
Ra=2024;%const de TL
Laa=1.596;%const de TL
J=(1.609e-07)/Laa; %const de wp
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
    omega = omega + h*wp;
    iap=(-Ra*ia-Km*omega+Va)/Laa;
    ia=ia+iap*h;
    thetap=omega;
    theta=theta+thetap*h;
end
X=[ia,omega,wp,theta];