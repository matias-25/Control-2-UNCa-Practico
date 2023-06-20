P=1;%PM7.4 del DORF 
num=[1+P -P]; 
den=[1 3 6]; 
G=tf(num,den);
figure(1);
rlocus(G)

T1=1/2; %Cero 
T2=1/5;%Polo 
alfa=T2/T1;%Da entre 0 y 1 
Kc=1; % K del rlocus(G) 
C=tf(Kc*[1 1/T1],[1 1/(alfa*T2)]);  
figure(2);
rlocus(C*G)

Kp = 1; 
Ki = 1;
C2= tf([Kp Ki,1 0]);
FLC=feedback(-1.12*C*G,1); % 


roots(FLC.Den{1})  
figure(3);
step(FLC,10)

figure(4);
bode(.3*C2*C*G) 
