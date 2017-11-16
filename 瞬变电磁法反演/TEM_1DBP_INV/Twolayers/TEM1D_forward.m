function [V,Hz] = TEM1D_forward(rho,h)
% rho为各层电阻，h为各层厚度
% V为观测电压
%%%%% 水平层状磁偶源 %%%%% 中心回线瞬变电磁一维正演 %%%%%  
%%%%% 刘威 %%%%% 中南大学 %%%%%
a=100;                             %发送回线半径                              
r=1;                               %接收回线半径
q=100*pi*r^2;                      %接收线圈的有效面积，100匝
miu0=4*pi*10^(-7);
a0=-7.91001919000e+00;             %偏移
s0=8.79671439570e-02;              %采样间隔
I0=10;                             %电流
hh=0;                              %线圈距离地表高度
w0=0.000001:200:10000000;          %频点，用于折现逼近法，原则上频点数越多，函数越光滑，精度越好。受计算速度限制，如此设置
N=length(rho);                     %地层层数
N1=length(w0);                     %频点数        
load 140Hankel;                    %汉克尔滤波系数
for i=1:N1
    w=w0(i);
    if N==1;                       %均匀半空间
        for m=1:140                %140个J1汉克尔滤波系数 m为采样位置
            lamda=(1/a)*10^(a0+(m-1)*s0);   
            u(N)=(lamda*lamda-j*w/rho(N)*miu0).^(1/2);
            z(N)=-j*w*miu0/u(N);
            Z(N)=z(N);
            z0=-j*w*miu0/lamda;
            YY(m)=exp(-lamda.*hh).*lamda.*(Z(1)./(Z(1)+z0)-1/2);
        end
    else                           %水平层状
        for m=1:140                
            lamda=(1/a)*10^(a0+(m-1)*s0); 
            u(N)=(lamda*lamda-j*w/rho(N)*miu0).^(1/2);
            z(N)=-j*w*miu0/u(N);
            Z(N)=z(N);
            for k=1:N-1            %计算Z(1)
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
for i=1:N1-1                       %折线逼近法
   SS=(ImHz(i+1)/w0(i+1)-ImHz(i)/(w0(i)))/(w0(i+1)-w0(i)).*(cos(w0(i).*t)-cos(w0(i+1).*t));   
   HH=HH+SS;
   SS1=(ReHz(i+1)-ReHz(i))/(w0(i+1)-w0(i)).*(cos(w0(i).*t)-cos(w0(i+1).*t));  
   HH1=HH1+SS1;
end
Hz=2./(pi.*t.*t).*HH;
V=-q*miu0*2./(pi.*t.*t).*HH1;
end

