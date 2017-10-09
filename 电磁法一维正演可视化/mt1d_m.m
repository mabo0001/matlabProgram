function [pa,phase_mt]=mt1d_m(rho_i,h_i)
%大地电磁一维正演
% X 波长/H1
%rho 电阻率
%h   介质厚度
%pa  视电阻率
%phase 相位

%2013-5-26
rho=rho_i;
h=h_i;
u=4*pi*10^(-7);
fmin=-8;
fmax=13;
fo=fmin:0.5:fmax;
f=2.^fo;        
w=2*pi*f;
N=length(rho);
for ki=1:length(f)
    for i=1:N
        k(i)=sqrt(-sqrt(-1)*w(ki)*u/rho(i));
    end
    ZN=-w(ki)*u/k(N);
    for i=N-1:-1:1
        A=-w(ki)*u/k(i);
        B=exp(-2*k(i)*h(i));
        Z0=A*(A*(1-B)+ZN*(1+B))/(A*(1+B)+ZN*(1-B));
        ZN=Z0;
    end
    pa(ki)=(abs(ZN))^2/w(ki)/u;
    %pa = pa_T./rho(1);
    phase_mt(ki)=atan(imag(ZN)/real(ZN))*180/pi;
end
end

 