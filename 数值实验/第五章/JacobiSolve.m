% 雅克比迭代解方程
clear
clc
A=[10,3,1;2,-10,3;1,3,10];
b=[14,-5,14];
xz=[1;1;1];
xk=[0;0;0];
n=size(A,2);

e=norm(xk-xz,inf);
count=0;
while(e>0.0001)
    for i=1:n
        
        sum1=0;
        if(i~=1)           
            for j=1:i-1
                sum1=sum1+A(i,j)*xk(j);
            end
        end
        
        sum2=0;
        if(i~=n)
            for j=i+1:n
                sum2=sum2+A(i,j)*xk(j);
            end
        end
        
        xk(i)=(b(i)-sum1-sum2)/A(i,i);
        
    end
    e=norm(xk-xz,inf);
    count=count+1;
end
