% 改进Euler公式
clear
clc
x(1)=0;
y(1)=1;
h=0.1;
N=10;

for k=1:N   
    a=y(k)+h*F_target(x(k),y(k));
    x(k+1)=x(1)+h*k;   
    y(k+1)=y(k)+0.5*h*(F_target(x(k),y(k))+F_target(x(k+1),a));

end
plot(x,y);
hold on
x0=0:0.1:1;
y0=x0+exp(-x0);
plot(x0,y0,'r*');

title('改进Euler法与准确解的对比图')
xlabel('x')
ylabel('y')
legend('改进Euler解','准确解',0)