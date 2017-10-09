function [x,y,L,U]=LU(a,b) 
n=length(a);
x=zeros(n,1);y=zeros(n,1);
U=zeros(n,n);L=eye(n,n); 
L(1:n,1)=a(1:n,1); 
U(1,1:n)=a(1,1:n)/L(1,1); 
for k=2:n
    for i=k:n
        L(i,k)=a(i,k)-L(i,1:(k-1))*U(1:(k-1),k);
    end
    for j=k:n
        U(k,j)=(a(k,j)-L(k,1:(k-1))*U(1:(k-1),j))/L(k,k);
    end
end
y(1,1)=b(1,1); 
for c=2:n             
    y(c,1)=b(c,1)-L(c,1:c-1)*y(1:c-1,1);
    x(n,1)=y(n,1)/U(n,n);
    for c=n-1:-1:1           
        x(c,1)=(y(c,1)-U(c,c+1:n)*x(c+1:n,1))/U(c,c); 
    end 
end