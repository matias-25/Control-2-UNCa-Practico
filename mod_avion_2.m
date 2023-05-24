function [X]=mod_avion_2(t_etapa, xant, accion) 
a=0.05; c=50; w=2; %b=5;
A=[-a a 0 0;0 0 1 0;w^2 -w^2 0 0;c 0 0 0];
B=[0;0;w^2;0];

At=1e-3;
% alfa=xant(1); 
% phi=xant(2);
% phip=xant(3);
% h=xant(4);
x=xant;
u=accion; %variable manipulada proporcional a la poscicion de los elevadores

for ii=1:t_etapa/At     
xp=A*x+B*u;
x=x+xp*At;
end 
X=x;