%Aqui convierte del espacio de estados a la funcion de
%transferencia
R=4700; L=10^(-5); C=100*10^(-9);
syms s G
A=[-R/L -1/L; 1/C 0];
B=[1/L;0];
C=[R 0];
D=0;
Maux=(s*eye(2)-A)^(-1);
G=(C*Maux*B);
disp(G); %este resultado es usando la fórmula

[num,den] = ss2tf(A,B,C,D);
G_1=tf(num,den);
disp(G_1); %este resultado es usando la fucion de MatLab
disp(roots(den));