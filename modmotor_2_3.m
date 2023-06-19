function [X]=modmotor_2_3(t_etapa, xant, accion)
%De la funcion de Transferencia obtenida del método de Chen
%wr=(16.52*Va-2024*TL)/(2.017e-08 s^2 + 0.0004693 s + 1) 
 %comparando con FT general se puede despejar las constantes 
B=0;%se considera la viscosidad motora nula
Raa=100;%const de TL 12V/0.12, de la curva
Km=1/16.52;%Ki/(KiKm)=16.52
Ki=Raa/(Km*2024);%Ra/(KiKm)=2024
J=(4.693e-4*Km*Ki)/Raa;%(J*Raa)/(KiKm)=4.693e-4
Laa=(2.017e-08*Ki*Km)/J;%(J*Laa)/(KiKm)=2.017e-08

Va=accion(1);
TL=accion(2);
TLp=0;
h=1e-7;
ia=xant(1);
omega= xant(2);
wp=xant(3);
theta=xant(4);
for ii=1:t_etapa/h
    
    wpp =(-wp*(Raa*J+Laa*B)-omega*(Raa*B+Ki*Km)+Va*Ki-TL*Raa-Laa*TLp)/(J*Laa);
    wp=wp+h*wpp;
    omega = omega + h*wp;
    iap=(-Raa*ia-Km*omega+Va)/Laa;
    ia=ia+iap*h;
    thetap=omega;
    theta=theta+thetap*h;
end
X=[ia,omega,wp,theta];