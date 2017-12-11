function [ L,U,y,x ] = LU_Doolittle( A,b )
%LU 分解 白冬鑫
%   此处显示详细说明
L=zeros(size(A));
U=zeros(size(A));
n=size(A,2);
for j=1:n;
    U(1,j)=A(1,j);
    L(j,1)=A(j,1)/U(1,1);
end

for k=2:n
    for j=k:n
        sum=0;
        for r=1:k-1
           sum=sum+ L(k,r)*U(r,j);
        end
        U(k,j)=A(k,j)-sum;
    end
    for i=k:n
        sum=0;
        for r=1:k-1
            sum=sum+L(i,r)*U(r,k);
        end
        L(i,k)=(A(i,k)-sum)/U(k,k);
    end
end
%解方程
y=zeros(n,1);
x=zeros(n,1);
y(1)=b(1);
for i=2:n
    sum=0;
    for r=1:i-1
        sum=sum+L(i,r)*y(r);
    end
    y(i)=b(i)-sum;
end

x(n)=y(n)/U(n,n);
for i=n-1:-1:1
    sum=0;
    for r=i+1:n
        sum=sum+U(i,r)*x(r);
    end
    x(i)=(y(i)-sum)/U(i,i);
end

end
