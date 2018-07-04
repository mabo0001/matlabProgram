clear
clc

x=-60:0.1:60;
theta=40*pi/180;
z=4;
x0=0;


%% ����������
r0=1;
% rho_1=100;
% rho_2=500;
% DU0=10;
q=1;

K_LQT=150;

[ V_leiqiuti ] = NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );
figure(1)
plot(x,V_leiqiuti)
xlabel('����/(m)')
ylabel('��λ��/(mV)')
title('������ģ����Ȼ�糡��һά����');
%% ��б��״������
rho_3=100;
% I=100;
L=10;
K_BZT=150;


[V_banzhuangti ] = NEF_forward_banzhuangti(  x,theta,z,x0,K_BZT,L );
figure(2)
plot(x,V_banzhuangti)
xlabel('����/(m)')
ylabel('��λ��/(mV)')
title('��б��״��ģ����Ȼ�糡��һά����');