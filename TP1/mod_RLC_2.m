function [X]=mod_RLC_2(t_etapa, xant, accion) 
R=5600; L=10e-6; C=100e-9;
A=[-R/L -1/L; 1/C 0];
B=[1/L;0];

At=9e-10; %At=9e-11, pero le pongo 10veces menos porque mi compu no lo soporta
x=xant; 
u=accion; %v_e

for ii=1:t_etapa/At     
xp=A*x+B*u;
x=x+xp*At;
end 
X=x;

