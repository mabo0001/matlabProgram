clear
clc
x0=[0,0.25,0.5,0.75,1.00];
x=min(x0):0.01:max(x0);
y0=[0.1,0.35,0.81,1.09,1.96];
m=2;
w=[1,1,1,1,1];
[ a ] = multifit( x0,y0,m,w )
y=zeros(size(x));
for i=1:size(x,2)
    yy=0;
    for j=1:m+1
       yy=yy+ a(j)*x(i).^(j-1);
    end
    y(i)=yy;
end

plot(x0,y0,'r*',x,y,'-')
title('离散数据拟合结果')
xlabel('x')
ylabel('y')
legend('离散数据','拟合数据',0)