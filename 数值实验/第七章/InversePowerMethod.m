% ·´ÃÝ·¨
clear
clc
A=[2,1,0;1,3,1;0,1,4];
u(:,1)=[1;1;1];
p=1.2;
eps=0.00001;

v(:,1)=u(:,1);
k=1;
e=1;
while(e>eps)
    v(:,k+1)=pinv(A-p*eye(size(A)))*u(:,k);
    u(:,k+1)=v(:,k+1)/max(v(:,k+1));
    e=abs(max(v(:,k+1)-max(v(:,k))));
    k=k+1;
end
lambda=p+1/max(v(:,end));