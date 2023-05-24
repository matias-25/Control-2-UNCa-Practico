clear;close all;
X=-[0; 0 ; 0 ;0];ii=0;t_etapa=1e-7;tF=0.5;

TL_in=0:t_etapa:tF;
TL=0;
u=12;
TLmax=0;
IaMax=0;
wpmax=0;
aux=0;
a=0;
for t=0:t_etapa:tF
    ii=ii+1;
    if ii<10001
       TL=0; %se deszplaza la funcion parábola para evitar el transitorio
       aux=ii;
    else
    TL=1e3*TL_in(ii-aux)*TL_in(ii-aux);%RECORDATORIO,SI MODIFICO LA PENDIENTE AQUI TAMBIEN LO DEBO HACER EN LA FUNCION osea TLp
    end
    X=modmotor_2_1b(t_etapa, X,[u,TL]);
    x1(ii)=X(1);%Omega
    x2(ii)=X(2);%wp
    x3(ii)=X(3);%ia
    acc(ii)=u;%u
    TL_parab(ii)=X(4);%TL
        if x1(ii)<0 && (TL_parab(ii)>0) && (a==0)
        IaMax=x3(ii-1); %Corriente armadura nominal o de trabajo a plena carga
        TLmax=TL_parab(ii-1); %torque de carga max
        wpmax=x2(ii-1);
        a=1;
        end
end

t=0:t_etapa:tF;
TL_const=TLmax*ones(1,length(t));

fprintf('TL PARABOLICO, Corriente armadura Max %d [A],con torque max de carga %d [N*m], wpmax %d',IaMax,TLmax,wpmax);
subplot(2,1,1);
plot(t,x1*1e-3,'c');title('Salida y, \omega_t *1e-3, i_a, Torque TL');hold on;
plot(t,x3,'r');hold on;
plot(t,TL_parab,'g');legend('\omega_t','ia','TL');grid on;hold on;
plot(t,TL_const,'-');
subplot(2,1,2);hold on;
plot(t,acc);title('Entrada u_t, v_a');
xlabel('Tiempo [Seg.]');