function [X,pa,phase]=mt_1d(rho,h)
%��ص��һά����
% X ����/H1
%rho ������
%h   ���ʺ��
%pa  �ӵ�����
%phase ��λ

%2013-5-26
u=4*pi*10^(-7);
t=logspace(-3,3,40);
f=1./t;
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
    pa_T(ki)=(abs(ZN))^2/w(ki)/u;
    pa = pa_T./rho(1);
    phase(ki)=atan(imag(ZN)/real(ZN))*180/pi;
end
X = sqrt(t.*10*rho(1))./h(1);
 