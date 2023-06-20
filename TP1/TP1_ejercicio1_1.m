clear;close all; 
X=-[0;0];ii=0;t_etapa=1e-9;tF=3e-3;

Ts=t_etapa; 
u=0; %12V
aux=0:t_etapa:tF;
aux1=int64((length(aux)/3)); 
aux2=int64((2*length(aux)/3));
for t=0:t_etapa:tF 
    ii=ii+1;
    if ii== aux1 %cambia a los 1ms
       u=12;
    end
    if ii== aux2 %cambia a los 2ms
       u=-12;
    end
    X=mod_RLC_1(t_etapa, X, u); 
    
    x1(ii)=X(1);%Corriente del Inductor
    x2(ii)=X(2);%Voltaje en el Capacitor
    acc(ii)=u;
end 
t=0:t_etapa:tF; 
subplot(3,1,1);hold on; 
plot(t,x1);title('Corriente'); grid on 
subplot(3,1,2);hold on; 
plot(t,acc);title('Voltaje Aplicado'); grid on
subplot(3,1,3);hold on; 
plot(t,x2);title('Voltaje en el capacitor'); grid on
xlabel('Tiempo [Seg.]');
