function f=NewtonInsertValueBack(x,y,xk)
%牛顿向后插值公式
% x=1.00:0.05:1.30;
% y=sqrt(x);
% xk=1.28;

t=(xk-x(end))/(x(2)-x(1));
f=y(end);
y1=0;
for i=1:size(y,2)-1
    for j=(i+1):size(y,2)
        y1(j)=y(j)-y(j-1);
    end
    c(i)=y1(end);
    l=t;
    for k=1:i-1
        l=l*(t+k);
    end
    f=f+c(i)*l/factorial(i);
    y=y1;
end
end