clear;close all; 
X=-[0;0;0];ii=0;t_etapa=1e-3;tF=12;
TL=0;
u=0; 
TitaRef=pi/2;
aux1=1; 
aux2=1;
cont=0:t_etapa:tF;
%Constantes del PID 
%Kp=.1;Ki=0.01;Kd=5;color_='r'; 
% Kp=0.5;Ki=1;Kd=0.001;color_='c'; 
Kp=1;Ki=0.01;Kd=0.001;
Ts=t_etapa;
A1=((2*Kp*Ts)+(Ki*(Ts^2))+(2*Kd))/(2*Ts); 
B1=(-2*Kp*Ts+Ki*(Ts^2)-4*Kd)/(2*Ts); 
C1=Kd/Ts; 
e=zeros(tF/t_etapa,1);

for t=0:t_etapa:tF 
    ii=ii+1;k=ii+2; 
    X=TP2_motor_varestados(t_etapa, X,[u;TL]); 
    e(k)=TitaRef-X(3); %ERROR 
    u=u+A1*e(k)+B1*e(k-1)+C1*e(k-2); %PID 
    x1(ii)=X(1);%w
    x2(ii)=X(2);%ia
    x3(ii)=X(3);%tita
    acc(ii)=u; 
     
    if cont(ii)==2
         TitaRef=pi/2;
     end
     if cont(ii)==4
         TitaRef=-pi/2;
     end
     if cont(ii)==6
         TitaRef=pi/2;
     end
     if cont(ii)==8
         TitaRef=-pi/2;
     end
     if cont(ii)==10
         TitaRef=pi/2;
     end
     if cont(ii)==12
         TitaRef=-pi/2;
     end
    if (x1(ii)>=99*pi/200 && x1(ii)<=101*pi/200 && aux1==1)
%     if (x1(ii)==pi/2 && aux1==1)
        TL=1.15e-3;
        aux1=0;
        aux2=1;
    end
    if (x1(ii)<=-99*pi/200 && x1(ii)>=-101*pi/200 && aux2==1)
%     if (x1(ii)==-pi/2 && aux2==1)
        TL=0;
        aux2=0;
        aux1=1;
    end
end 
t=0:t_etapa:tF; 
subplot(4,1,1); 
plot(t,x1/pi);title('Salida y, \theta_t [RAD]');
subplot(4,1,2); 
plot(t,x2);title('Velocidad angular \omega_t');
subplot(4,1,3); 
plot(t,x3);title('Corriente i_a');
subplot(4,1,4);
plot(t,acc);title('Entrada u_t, v_a');hold on;
xlabel('Tiempo [Seg.]'); 