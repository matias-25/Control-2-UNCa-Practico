P=1;%PM7.4 del DORF 
num=[1+P -P]; 
den=[1 3 6]; 
G=tf(num,den);

T1=1/2; %Cero 
T2=1/5;%Polo 
alfa=T2/T1;%Da entre 0 y 1 
Kc=1; % K del rlocus(G) 
C=tf(Kc*[1 1/T1],[1 1/(alfa*T2) ]);  
rlocus(C*G)