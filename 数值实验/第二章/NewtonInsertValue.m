function f= NewtonInsertValue(x,y,xk)
%均差的牛顿插值法
% x=[2.0 2.1 2.2];
% y=[1.414214 1.449138 1.483240];
% xk=2.15;
k=1;
f=y(1);
for i=1:size(y,2)-1
    for j=i+1:size(y,2)
        y(j)=(y(j)-y(i))/(x(j)-x(i));
    end
    k=k*(xk-x(i));
    f=f+y(i+1)*k;
end