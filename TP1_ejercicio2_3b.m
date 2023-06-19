clear;close all;
A = xlsread('Curvas_Medidas_Motor.xls');
tm = A(:,1); %tiempo en segundos
wr = A(:,2); %velocidad angular [Rad/seg] 
iam = A(:,3); %corriente de armadura[A]
X=-[0; 0 ; 0; 0];ii=0;%t_etapa=1e-6;tF=5;
tF=length(tm);
t_etapa=1/tF;
TL=0;
u=0;
for t=1:tF
    ii=ii+1;
    X=modmotor_2_3(t_etapa, X,[u,TL]);
    x1(ii)=X(1);%ia
    x2(ii)=X(2);%Omega velocidad angular
    x3(ii)=X(3);%wp aceleracion angular
    x4(ii)=X(4);%tita, angulo de salida
    acc(ii)=u;%u escalón entrada
    accTL(ii)=TL;%escalon Torque
    
     if tm(ii)>=0.0201
        u=12; 
     end
        if tm(ii)>0.1
        TL=7.5e-2; 
        end
end
t=0:tF-1;

figure(1);
subplot(5,1,1);
plot(t,x1);hold on;plot(t,iam,'r');title('Corriente i_a'); legend('Calculada','Medida');
subplot(5,1,2);
plot(t,x2);hold on;plot(t,wr,'r');title(' \omega_t');legend('Calculada','Medida');
subplot(5,1,3);
plot(t,x3);title('Salida wp');
subplot(5,1,4);
plot(t,x4);title('Salida \theta_t');
subplot(5,1,5);
plot(t,accTL);title('Torque de Carga');
xlabel('Tiempo [Seg.]');
figure(2);
subplot(2,1,1);
plot(t,iam,'r');title('Corriente i_a medida');
subplot(2,1,2);
plot(t,acc);title('u entrada'); 


