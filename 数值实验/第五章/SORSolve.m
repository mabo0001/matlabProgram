% ³¬ËÉ³Úµü´úSOR
clear
clc
% A=[10,3,1;2,-10,3;1,3,10];
% b=[14,-5,14];
% xz=[1;1;1];
A=[4,3,0;3,4,-1;0,-1,4];
b=[24;30;-24];
% xz=[];

xk=[1;1;1];
n=size(A,2);

% e=norm(xk-xz,inf);
e=1;
count=0;
k=1;
w=1.25;
while(e>0.0001)
    
    for i=1:n
        sum1=0;
        if(k~=i)
            for j=1:i-1
                sum1=sum1+A(i,j)*xk(j,k+1);
            end
        end
            
            sum2=0;
            if(n~=i)
                for j=i+1:n
                    sum2=sum2+A(i,j)*xk(j,k);
                end
            end
        xk(i,k+1)=w*(b(i)-sum1-sum2)/A(i,i)+(1-w)*xk(i,k);
        
    end
%     e=norm(xk(:,k)-xz,inf);
    e=norm(xk(:,k+1)-xk(:,k),inf);
    k=k+1;
    
    count=count+1;
end
