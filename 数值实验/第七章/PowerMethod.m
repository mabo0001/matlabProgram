% ÃÝ·¨
clear
clc
A=[1,1,0.5;1,1,0.25;0.5,0.25,2];
u(:,1)=[1;1;1];
eps=0.00001;

v(:,1)=u(:,1);
k=1;
e=1;
while(e>eps)
    v(:,k+1)=A*u(:,k);
    u(:,k+1)=v(:,k+1)/max(v(:,k+1));
    e=abs(max(v(:,k+1)-max(v(:,k))));
    k=k+1;
end
lambda=max(v(:,end));