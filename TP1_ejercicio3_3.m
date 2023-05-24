clear;close all; 
X=-[0;0;0;0];ii=0;t_etapa=1e-3;tF=20;

Ts=t_etapa; 
u=1;

for t=0:t_etapa:tF 
    ii=ii+1;
    X=mod_avion_2(t_etapa, X, u); 
    x1(ii)=X(1);%alfa
    x2(ii)=X(2);%phi
    x3(ii)=X(3);%phip
    x4(ii)=X(4);%h
    acc(ii)=u;%variable manipulada proporcional a la poscicion de los elevadores
end 
t=0:t_etapa:tF; 
subplot(3,2,1);
plot(t,x1);title('Ángulo con la horizontal alfa'); grid on 
subplot(3,2,2);hold on; 
plot(t,x2);title('Ángulo de cabeceo phi'); grid on
subplot(3,2,3);hold on; 
plot(t,x3);title('phip'); grid on 
subplot(3,2,4);hold on; 
plot(t,x4);title('Altura h'); grid on
subplot(3,2,5);hold on; 
plot(t,acc);title('Entrada u'); grid on
xlabel('Tiempo [Seg.]');