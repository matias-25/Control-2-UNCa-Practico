clear;close all;
X=-[0; 0 ; 0; 0];ii=0;t_etapa=1e-6;tF=5;
IaMax=0;
TL=0;
u=0;
for t=0:t_etapa:tF
    ii=ii+1;
    X=modmotor_2_1(t_etapa, X,[u,TL]);
    x1(ii)=X(1);%ia
    x2(ii)=X(2);%Omega velocidad angular
    x3(ii)=X(3);%wp aceleracion angular
    x4(ii)=X(4);%tita, angulo de salida
    acc(ii)=u;%u escalón entrada
    accTL(ii)=TL;%escalon Torque
    
        if x1(ii)>IaMax
        IaMax=x1(ii); %Corriente armadura nominal o de trabajo a plena carga
        end
     if t>=tF/5
        u=12; 
     end
        if t>=3*tF/5
        TL=1.4007e-3; 
        end
end
t=0:t_etapa:tF;

fprintf('Corriente armadura Max %d [A],con torque max de carga %d [N*m]',IaMax,TL);
subplot(6,1,1);
plot(t,x1);title('Corriente i_a');
subplot(6,1,2);
plot(t,x2);title(' \omega_t');
subplot(6,1,3);
plot(t,x3);title('Salida wp');
subplot(6,1,4);
plot(t,x4);title('Salida \theta_t');
subplot(6,1,5);
plot(t,acc);title('Entrada v_a');
subplot(6,1,6);
plot(t,accTL);title('Torque de Carga');
xlabel('Tiempo [Seg.]');