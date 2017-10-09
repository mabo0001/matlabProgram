function [rhos,phase]=MT1D_zhengyan(rho,h)
%��ص�Ų���һά����
%   �˴���ʾ��ϸ˵��
mu=(4e-7)*pi;
T=logspace(-3,4,100);
k=zeros(size(rho,2),size(T,2));%Ϊ����ϵ��k��������ڴ�
for N=1:size(rho,2)%����ÿ������㲻ͬʱ�̵Ĵ���ϵ��k�ľ���
    k(N,:)=sqrt(-i*2*pi*mu./(rho(N).*T));
end 
m=size(rho,2);
Z=-(i*mu*2*pi)./(k(m,:).*T);%��n����������迹
for n=m-1:-1:1%���ƹ�ʽ
    P=-(i*2*pi*mu)./(k(n,:).*T);
    Q=exp(-2*k(n,:)*h(n));
    Z=P.*(P.*(1-Q)+Z.*(1+Q))./(P.*(1+Q)+Z.*(1-Q));
end
rhos=(1./(mu*2*pi./T)).*(abs(Z).^2);%�����迹������ʺ���λ
phase=-atan(imag(Z)./real(Z)).*180/pi;
end