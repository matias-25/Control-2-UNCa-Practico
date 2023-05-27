function [X]=TP2_motor_varestados(t_etapa, xant, accion) 
Laa=5e-3; J=4e-3;Ra=0.2;B=5e-3;Ki=6.5e-5;Km=55e-3;
A=[-Ra/Laa -Km/Laa 0;-Ki/J -B/J 0;0 1 0];
B=[1/Laa 0;0 1/J;0 0];

At=1e-4; %At
x=xant; 
u=accion; %v_a, TL

for ii=1:t_etapa/At     
xp=A*x+B*u;
x=x+xp*At;
end 
X=x;

