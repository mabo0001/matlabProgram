function f=NewtonInsertValueForward(x,y,xk)
%牛顿向前插值公式
% x=1.00:0.05:1.30;
% y=sqrt(x);
% xk=1.01;

t=(xk-x(1))/(x(2)-x(1));
f=y(1);
y1=0;
for i=1:size(y,2)-1
    for j=1:size(y,2)-i
        y1(j)=y(j+1)-y(j);
    end
    c(i)=y1(1);
    l=t;
    for k=1:i-1
        l=l*(t-k);
    end
    f=f+c(i)*l/factorial(i);
    y=y1;
end
end