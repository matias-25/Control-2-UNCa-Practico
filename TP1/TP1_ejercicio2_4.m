clear;close all;
X=-[0; 0 ; 0; 0];ii=0;
tF=.5;%length(tm);
t_etapa=1e-6;
TL=0;
u=0;
theta_ref=pi; %[grados]
%Constantes del PID
% Kp=0.1;Ki=0.01;Kd=5;%tips sugerido
Kp=100;Ki=0.01;Kd=0.01;
Ts=t_etapa;
A1=((2*Kp*Ts)+(Ki*(Ts^2))+(2*Kd))/(2*Ts);
B1=(-2*Kp*Ts+Ki*(Ts^2)-4*Kd)/(2*Ts);
C1=Kd/Ts;
e=zeros(tF/t_etapa,1);
aux=0:t_etapa:tF;
for t=0:t_etapa:tF
    ii=ii+1;
    k=ii+2;%contador para el PID
    X=modmotor_2_3(t_etapa, X,[u,TL]);
    e(k)=theta_ref - X(4); %ERROR
    u=u+A1*e(k)+B1*e(k-1)+C1*e(k-2); %PID
    x1(ii)=X(1);%ia
    x2(ii)=X(2);%Omega velocidad angular
    x3(ii)=X(3);%wp aceleracion angular
    x4(ii)=X(4);%tita, angulo de salida
    %acc(ii)=u;%u escalón entrada
    accTL(ii)=TL;%escalon Torque
    theta_refd(ii)=theta_ref;
        if aux(ii)>=0.1
        TL=7.5e-2; 
        end
        
end
t=0:t_etapa:tF;


subplot(5,1,1);
plot(t,x1);title('Corriente i_a'); 
subplot(5,1,2);
plot(t,x2);title(' \omega_t con PID');
subplot(5,1,3);
plot(t,x3);title('Salida wp');
subplot(5,1,4);
plot(t,x4);hold on; plot(t,theta_refd,'c');title('Salida \theta_t');
subplot(5,1,5);
plot(t,accTL);title('Torque de Carga');
xlabel('Tiempo [Seg.]');
