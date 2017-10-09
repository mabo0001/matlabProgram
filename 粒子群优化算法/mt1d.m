function rhos=mt1d(lambda)
%自己编写的MT一维正演

rho=lambda(1:(size(lambda,2)+1)/2);
h=lambda((size(lambda,2)+1)/2+1:end);
mu=(4e-7)*pi;
T=logspace(-3,4,100);
n=size(rho,2);
for N=1:n
    k(N,:)=sqrt(-2*pi*mu*i./(rho(N).*T));
end
Z=-i*mu*2*pi./(k(n,:).*T);

for m=n-1:-1:1
    Zm=-i*mu*2*pi./(k(m,:).*T);
    L=(Zm-Z)./(Zm+Z);
    Z=Zm.*(1-L.*exp(-2*k(m,:).*h(m)))./(1+L.*exp(-2*k(m,:).*h(m)));
end
f=2*pi./T;
rhos=(1./(mu.* f)).*(abs(Z).^2);%利用阻抗求电阻率和相位

% semilogx(f,rhos);
% xlabel('频率(Hz)');
% ylabel('视电阻率(欧姆)');
% title('一维地电模型MT正演');
end