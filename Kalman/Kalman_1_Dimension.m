%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   一维Kalman滤波仿真 
%   随机信号模型  s(n)=a*s(n-1)+v(n-1)    
%   观察测量模型  x(n)=c*s(n)+w(n)
%   噪声方差 dv,dw
%   Kalman滤波估计 sest(n)=a*sest(n-1)+K(n)*[x(n)-a*c*sest(n-1)]
%   滤波器修正系数 K(n)=c*[a^2*p(n-1)+dv]/[dw+c^2*dv+c^2*a^2*p(n-1)]
%   均方误差 p(n)=dw*K(n)/c
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear
clc

N=100;
a=0.8;
c=1;
dv=0;
dw=1;
s(1)=25;
v=randn(1,N)*sqrt(dv); % v也好似一个序列 v(n-1)表示单个元素
for i=2:N
    s(i)=a*s(i-1)+v(i);
end
x=c*s+randn(1,N)*sqrt(dw); %randn(1,N)=randn([1,N]) x是一个序列
%%%%%%%%%%%%%%%%%%%%%%  信号产生 %%%%%%%%%%%%%%%%%%%%%%%%%%%%


sest(1)=1;
p=10;
%%%%%%%%%%%%%%%%%%%%% 设置初始值 %%%%%%%%%%%%%%%%%%%%%%%%%%%%


% N=300;
% a=1;
% c=1;
% dv=0;
% dw=0.5;
% s(1)=20;
% v=randn(1,N)*sqrt(dv);
% for i=2:N
%     s(i)=a*s(i-1)+v(i);
% end
% x=c*s+randn(1,N)*sqrt(dw);
% 
% sest(1)=0;
% p=1;

for i=2:N
    k=c*(a^2*p+dv)/(dw+c^2*dv+c^2*a^2*p)
    sest(i)=a*sest(i-1)+k*(x(i)-a*c*sest(i-1));
    p=dw*k/c
end
%%%%%%%%%%%%%%%%%%%% 滤波过程 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


t=1:N;
plot(t,s,'r',t,x,'g',t,sest,'k');
legend('expected','measured','Kalman Result');
axis([0 N min(x)-1 max(x)+1])
%%%%%%%%%%%%%%%%%%%% 作图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%