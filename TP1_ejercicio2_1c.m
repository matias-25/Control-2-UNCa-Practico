clear;close all;
X=-[0; 0 ; 0 ];ii=0;t_etapa=1e-6;tF=5;
IaMax=0;
TL=1.4007194e-3;
u=12;
for t=0:t_etapa:tF
    ii=ii+1;
    X=modmotor_2_1b(t_etapa, X,[u,TL]);
    x1(ii)=X(1);%Omega
    x2(ii)=X(2);%wp
    x3(ii)=X(3);%ia
    acc(ii)=u;%u
    
        if x3(ii)>IaMax
        IaMax=x3(ii); %Corriente armadura nominal o de trabajo a plena carga
        end
end
t=0:t_etapa:tF;

fprintf('Corriente armadura Max %d [A],con torque max de carga %d [N*m]',IaMax,TL);
subplot(2,1,1);
plot(t,x1*1e-3,'c');title('Salida y, \omega_t *1e-3, i_a, Torque TL');hold on;
plot(t,x3,'r');hold on;legend('\omega_t','ia');grid on;
subplot(2,1,2);
plot(t,acc);title('Entrada u_t, v_a');
xlabel('Tiempo [Seg.]');