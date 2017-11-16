function [V,Hz] = TEM1D_forward(rho,h)
% rhoΪ������裬hΪ������
% VΪ�۲��ѹ
%%%%% ˮƽ��״��żԴ %%%%% ���Ļ���˲����һά���� %%%%%  
%%%%% ���� %%%%% ���ϴ�ѧ %%%%%
a=100;                             %���ͻ��߰뾶                              
r=1;                               %���ջ��߰뾶
q=100*pi*r^2;                      %������Ȧ����Ч�����100��
miu0=4*pi*10^(-7);
a0=-7.91001919000e+00;             %ƫ��
s0=8.79671439570e-02;              %�������
I0=10;                             %����
hh=0;                              %��Ȧ����ر�߶�
w0=0.000001:200:10000000;          %Ƶ�㣬�������ֱƽ�����ԭ����Ƶ����Խ�࣬����Խ�⻬������Խ�á��ܼ����ٶ����ƣ��������
N=length(rho);                     %�ز����
N1=length(w0);                     %Ƶ����        
load 140Hankel;                    %���˶��˲�ϵ��
for i=1:N1
    w=w0(i);
    if N==1;                       %���Ȱ�ռ�
        for m=1:140                %140��J1���˶��˲�ϵ�� mΪ����λ��
            lamda=(1/a)*10^(a0+(m-1)*s0);   
            u(N)=(lamda*lamda-j*w/rho(N)*miu0).^(1/2);
            z(N)=-j*w*miu0/u(N);
            Z(N)=z(N);
            z0=-j*w*miu0/lamda;
            YY(m)=exp(-lamda.*hh).*lamda.*(Z(1)./(Z(1)+z0)-1/2);
        end
    else                           %ˮƽ��״
        for m=1:140                
            lamda=(1/a)*10^(a0+(m-1)*s0); 
            u(N)=(lamda*lamda-j*w/rho(N)*miu0).^(1/2);
            z(N)=-j*w*miu0/u(N);
            Z(N)=z(N);
            for k=1:N-1            %����Z(1)
                u(N-k)=(lamda*lamda-j*w/rho(N-k)*miu0).^(1/2);
                z(N-k)=-j*w*miu0/u(N-k);
                Z(N-k)=z(N-k)*(Z(N-k+1)+z(N-k)*tanh(u(N-k)*h(N-k)))/(z(N-k)+Z(N-k+1)*tanh(u(N-k)*h(N-k)));
            end
            z0=-j*w*miu0/lamda;
            YY(m)=exp(-lamda.*hh).*lamda.*(Z(1)./(Z(1)+z0)-1/2);  
        end
    end
    Y1=I0.*YY'.*wt1;
    ReHz(i)=real(sum(Y1)+I0/2/a);
    ImHz(i)=imag(sum(Y1)+I0/2/a);
end
t=logspace(-7,-2,50);
HH=0;
HH1=0;
for i=1:N1-1                       %���߱ƽ���
   SS=(ImHz(i+1)/w0(i+1)-ImHz(i)/(w0(i)))/(w0(i+1)-w0(i)).*(cos(w0(i).*t)-cos(w0(i+1).*t));   
   HH=HH+SS;
   SS1=(ReHz(i+1)-ReHz(i))/(w0(i+1)-w0(i)).*(cos(w0(i).*t)-cos(w0(i+1).*t));  
   HH1=HH1+SS1;
end
Hz=2./(pi.*t.*t).*HH;
V=-q*miu0*2./(pi.*t.*t).*HH1;
end

