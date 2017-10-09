% 经典R-K法
clear
clc
x(1)=0;
y(1)=1;
h=0.1;
N=10;

for k=1:N
    K1=F_target(x(k),y(k));
    K2=F_target(x(k)+0.5*h,y(k)+0.5*h*K1);
    K3=F_target(x(k)+0.5*h,y(k)+0.5*h*K2);
    K4=F_target(x(k)+h,y(k)+h*K3);
    x(k+1)=x(1)+h*k; 
    y(k+1)=y(k)+(K1+2*K2+2*K3+K4)*h/6;
    
end

plot(x,y);
hold on
x0=0:0.1:1;
y0=x0+exp(-x0);
plot(x0,y0,'r*');

title('经典R—K法与准确解的对比图')
xlabel('x')
ylabel('y')
legend('经典R—K解','准确解',0)