close all; clear;
A = xlsread('Curvas_Medidas_Motor.xls');
t = A(:,1); %tiempo en segundos
wr = A(:,2); %velocidad angular [Rad/seg] 
ia = A(:,3); %corriente de armadura[A]

figure(1);
subplot(2,1,1);
plot(t,wr); title('velocidad angular [Rad/seg], wr'); grid on;
subplot(2,1,2);
plot(t,ia);title('Corriente armadura [A], ia'); grid on;

%Escalón voltaje de 12V
StepAmplitude=12;
temp_co=3659;
t_s=t(temp_co:22991)-t(temp_co); %dezplazo el eje t
y=wr(temp_co:22991); %se analiza la seccion del Escalon positivo 
t0=t_s;
t_inic=0.0217-t(temp_co); %tiempo inicial 
[val lugar] =min(abs(t_inic-t0)); 
y_t1=y(lugar); 
t_t1=t0(lugar); 
ii_TL=1; 
[val lugar] =min(abs(2*t_inic-t0)); 
t_2t1=t0(lugar); 
y_2t1=y(lugar); 
[val lugar] =min(abs(3*t_inic-t0)); 
t_3t1=t0(lugar); 
y_3t1=y(lugar); 
K=198.2488/StepAmplitude; 
k1=(1/StepAmplitude)*y_t1/K-1;%Afecto el valor del Escalon 
k2=(1/StepAmplitude)*y_2t1/K-1; 
k3=(1/StepAmplitude)*y_3t1/K-1; 
be=4*k1^3*k3-3*k1^2*k2^2-4*k2^3+k3^2+6*k1*k2*k3; 
alfa1=(k1*k2+k3-sqrt(be))/(2*(k1^2+k2)); 
alfa2=(k1*k2+k3+sqrt(be))/(2*(k1^2+k2)); 
beta=(k1+alfa2)/(alfa1-alfa2); 

T1_ang=-t_t1/log(alfa1); 
T2_ang=-t_t1/log(alfa2); 
T3_ang=beta*(T1_ang-T2_ang)+T1_ang; 
T1(ii_TL)=T1_ang; 
T2(ii_TL)=T2_ang; 
T3(ii_TL)=T3_ang; 
T3_ang=sum(T3/length(T3)); 
T2_ang=sum(T2/length(T2)); 
T1_ang=sum(T1/length(T1)); 
sys_G_ang_va=tf(K*[T3_ang 1],conv([T1_ang 1],[T2_ang 1]))
y_id=StepAmplitude*step(sys_G_ang_va , t_s );

figure(2);
plot(t_s,y,'r');legend('Real'),hold on
plot(t_t1,y_t1,'*')
plot(t_2t1,y_2t1,'o')
plot(t_3t1,y_3t1,'o')
plot(t_s,y_id,'k'); hold on
% step(StepAmplitude*G_Resul,'c');
%legend('Real','Intervalo 1','Intervalo 2','Intervalo 3','Identificada'); 
%legend('boxoff');grid on

%Escalón de Torque de carga
StepTL=-7.5e-2;
temp_co_TL=6326;
t_s_TL=t(temp_co_TL:22991)-t(temp_co_TL); %dezplazo el eje t
y_TL=wr(temp_co_TL:22991); %se analiza la seccion del Escalon positivo 
t0_TL=t_s_TL;
t_inic_TL=0.1009-t(temp_co_TL);  %tiempo inicial 
[val_TL lugar_TL] =min(abs(t_inic_TL-t0_TL));
y_t1_TL=y_TL(lugar_TL); 
t_t1_TL=t0_TL(lugar_TL); 
ii_TL=1; 
[val_TL lugar_TL] =min(abs(2*t_inic_TL-t0_TL)); 
t_2t1_TL=t0_TL(lugar_TL); 
y_2t1_TL=y_TL(lugar_TL); 
[val_TL lugar_TL] =min(abs(3*t_inic_TL-t0_TL)); 
t_3t1_TL=t0_TL(lugar_TL); 
y_3t1_TL=y_TL(lugar_TL); 
K_TL=y_TL(end)/StepTL; 
k1_TL=(1/StepTL)*y_t1_TL/K_TL-1;%Afecto el valor del Escalon 
k2_TL=(1/StepTL)*y_2t1_TL/K_TL-1; 
k3_TL=(1/StepTL)*y_3t1_TL/K_TL-1; 
be_TL=4*k1_TL^3*k3_TL-3*k1_TL^2*k2_TL^2-4*k2_TL^3+k3_TL^2+6*k1_TL*k2_TL*k3_TL; 
alfa1_TL=(k1_TL*k2_TL+k3_TL-sqrt(be_TL))/(2*(k1_TL^2+k2_TL)); 
alfa2_TL=(k1_TL*k2_TL+k3_TL+sqrt(be_TL))/(2*(k1_TL^2+k2_TL)); 
beta_TL=(k1_TL+alfa2_TL)/(alfa1_TL-alfa2_TL); 

T1_ang_TL=-t_t1_TL/log(alfa1_TL); 
T2_ang_TL=-t_t1_TL/log(alfa2_TL); 
T3_ang_TL=beta_TL*(T1_ang_TL-T2_ang_TL)+T1_ang_TL; 
T1_TL(ii_TL)=T1_ang_TL; 
T2_TL(ii_TL)=T2_ang_TL; 
T3_TL(ii_TL)=T3_ang_TL; 
T3_ang_TL=sum(T3_TL/length(T3_TL)); 
T2_ang_TL=sum(T2_TL/length(T2_TL)); 
T1_ang_TL=sum(T1_TL/length(T1_TL)); 
sys_G_ang_TL=tf(K_TL*[T3_ang_TL 1],conv([T1_ang_TL 1],[T2_ang_TL 1]))
aux=temp_co_TL-temp_co;
y_id_TL=[198.2488*ones(aux,1);StepTL*step(sys_G_ang_TL , t_s_TL)];

figure(2);
%plot(t_s,y,'r'),hold on
plot(t_t1_TL + t_s(aux),y_t1_TL,'*');hold on
plot(t_2t1_TL + t_s(aux),y_2t1_TL,'o')
plot(t_3t1_TL + t_s(aux),y_3t1_TL,'o')
plot(t_s,y_id_TL,'c');grid on
% step(StepAmplitude*G_Resul,'c');
%legend('Real','Intervalo 1','Intervalo 2','Intervalo 3','Identificada'); 
%legend('boxoff');grid on
