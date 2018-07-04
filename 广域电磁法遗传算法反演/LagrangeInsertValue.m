function L= LagrangeInsertValue(x,y,xk)
%拉格朗日插值
% x=[0.4 0.5 0.7 0.8];
% y=[-0.916291 -0.693147 -0.356675 -0.223144];
% xk=0.75;

L=0;
for i=1:size(x,2)
    k=1;
    for j=1:size(x,2)
        if(j==i)
          continue;
        else
            k=k*((xk-x(j))/(x(i)-x(j)));
        end
    end
    L=L+y(i)*k;
end