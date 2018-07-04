clear
clc

x=-60:1:60;
theta=40*pi/180;
z=4;
x0=0;


%% 类球体正演
r0=1;
% rho_1=100;
% rho_2=500;
% DU0=10;
q=1;

K_LQT=150;

[ V_LQT ] = NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );

% [V_LQT,x]=forward_LQT(-60:1:60,40*pi/180,1,4,0,-500);
zaosheng=0.2;
 V_LQT_zaosheng=V_LQT+zaosheng.*(-1+2*rand(size(V_LQT))).*V_LQT;%这就是为场值加了20%的噪声
% V_LQT_zaosheng=add_noise(V_LQT,zaosheng);
delete('V_withNoise.txt')
fid=fopen('V_withNoise.txt','wt');
fprintf(fid,'%d ',x);
fprintf(fid,'%d \n','');
fprintf(fid,'%d ',V_LQT_zaosheng);
fclose(fid);

% delete('V_withouthNoise.txt')
% fid=fopen('V_withoutNoise.txt','wt');
% fprintf(fid,'%d \r\n',x);
% fprintf(fid,'%d \r\n',V_LQT);
% fclose(fid);
