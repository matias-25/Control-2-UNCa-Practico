clear;close all;
X=-[0; 0 ; 0];ii=0;t_etapa=1e-7;tF=5;

TL_in=0:t_etapa:tF;
TL=0;
u=12;
wmax=0;
TLmax=0;
aux=0;
for t=0:t_etapa:tF
    ii=ii+1;
    if ii<100000
       TL=0; %se deszplaza la funcion rampa para evitar el transitorio
       aux=ii;
     else
       TL=(1e-5)*TL_in(ii-aux);%RECORDATORIO,SI MODIFICO LA PENDIENTE AQUI TAMBIEN LO DEBO HACER EN LA FUNCION osea TLp
    end
    X=modmotor_2_1a(t_etapa, X,[u,TL]);
    x1(ii)=X(1);%Omega
    x2(ii)=X(2);%wp
    acc(ii)=u;%u
    TL_rampa(ii)=X(3);%TL
    if x1(ii)>wmax
        wmax=x1(ii); %velocidad angular max, a plena carga
        TLmax=X(3); %torque de carga max
    end
end
fprintf('TL RAMPA velocidad angular max %d [Rad/seg],con torque max de carga %d [N*m]',wmax,TLmax);
t=0:t_etapa:tF;
subplot(3,1,1);hold on;
plot(t,x1);title('Salida y, \omega_t');
subplot(3,1,2);hold on;
plot(t,acc);title('Entrada u_t, v_a');
subplot(3,1,3);hold on;
plot(t, TL_rampa);title('Torque Rampa, TL');
xlabel('Tiempo [Seg.]');
% % Para verificar
% Laa=366e-6;
% J=5e-9;
% Ra=55.6;
% B=0;
% Ki=6.49e-3;
% Km=6.53e-3;
% num=[Ki]
% den=[Laa*J Ra*J+Laa*B Ra*B+Ki*Km ]; %wpp*Laa*J+wp*(Ra*J+Laa*B)+w*(Ra*B+Ki*Km)=Vq*Ki
% sys=tf(num,den)
% step(sys)