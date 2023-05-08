clear;close all;
X=-[0; 0 ; 0 ;0];ii=0;t_etapa=1e-7;tF=5;

TL_in=0:t_etapa:tF;
TL=0;
u=12;
wmax=0;
TLmax=0;
Iam=0;
IaMax=0;
aux=0;

for t=0:t_etapa:tF
    ii=ii+1;
    if ii<10001
       TL=0; %se deszplaza la funcion parábola para evitar el transitorio
       aux=ii;
    else
    TL=1e-4*TL_in(ii-aux)*TL_in(ii-aux);%RECORDATORIO,SI MODIFICO LA PENDIENTE AQUI TAMBIEN LO DEBO HACER EN LA FUNCION osea TLp
    end
    X=modmotor_2_1b(t_etapa, X,[u,TL]);
    x1(ii)=X(1);%Omega
    x2(ii)=X(2);%wp
    x3(ii)=X(3);%ia
    acc(ii)=u;%u
    TL_parab(ii)=X(4);%TL
        if x1(ii)>wmax
        wmax=x1(ii); %velocidad angular max, a plena carga
        Iam=X(3); %Corriente armadura nominal o de trabajo a plena carga
        TLmax=X(4); %torque de carga max
        end
        if (x3(ii)>IaMax) && (x1(ii)>0)
        IaMax=X(3); %Corriente armadura max
        end
end
fprintf('TL PARABOLICO,velocidad angular max %d [Rad/seg],Corriente armadura nominal %d [A],con torque max de carga %d [N*m], la IaMax %d[A]',wmax,Iam,TLmax,IaMax);
t=0:t_etapa:tF;
subplot(3,1,1);
plot(t,x1/10000);title('Salida y, \omega_t /10000 , i_a');hold on;
plot(t,x3,'r');legend('\omega_t','ia');
subplot(3,1,2);hold on;
plot(t,acc);title('Entrada u_t, v_a');
subplot(3,1,3);hold on;
plot(t,TL_parab);title('Torque, TL');
xlabel('Tiempo [Seg.]');