%Aqui conviertea de la matriz de las ecuaciones de estados a la funcion de
%trnferencia
R=4700; L=10^(-5); C=100*10^(-9);
syms s G
A=[-R/L -1/L; 1/C 0];
B=[1/L;0];
C=[R 0];
Maux=inv(s*eye(2)-A);
G=(C*Maux*B)
