function [ L,d,y,x ] = CholeskyOptimize( A,b )
%改进Cholesky分解解方程
%   此处显示详细说明
n=size(A,2);
L=zeros(n,n);
d(1,1)=A(1,1);
for i=1:n
    L(i,i)=1;
end

for j=1:n
    sum=0;
    for k=1:j-1
        sum=sum+L(j,k)*L(j,k)*d(k,k);
    end
    d(j,j)=A(j,j)-sum;
    for i=j+1:n
        sum=0;
        for k=1:j-1
            sum=sum+d(k,k)*L(i,k)*L(j,k);
        end
        L(i,j)=(A(i,j)-sum)/d(j,j);
    end
end
y=pinv(L)*b;
x=pinv(L')*pinv(d)*y;


end

