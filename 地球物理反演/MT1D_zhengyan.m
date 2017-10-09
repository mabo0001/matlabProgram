function [rhos,phase]=MT1D_zhengyan(rho,h)
%大地电磁测深一维正演
%   此处显示详细说明
mu=(4e-7)*pi;
T=logspace(-3,4,100);
k=zeros(size(rho,2),size(T,2));%为传播系数k分配计算内存
for N=1:size(rho,2)%计算每个电阻层不同时刻的传播系数k的矩阵
    k(N,:)=sqrt(-i*2*pi*mu./(rho(N).*T));
end 
m=size(rho,2);
Z=-(i*mu*2*pi)./(k(m,:).*T);%第n层介质特征阻抗
for n=m-1:-1:1%递推公式
    P=-(i*2*pi*mu)./(k(n,:).*T);
    Q=exp(-2*k(n,:)*h(n));
    Z=P.*(P.*(1-Q)+Z.*(1+Q))./(P.*(1+Q)+Z.*(1-Q));
end
rhos=(1./(mu*2*pi./T)).*(abs(Z).^2);%利用阻抗求电阻率和相位
phase=-atan(imag(Z)./real(Z)).*180/pi;
end