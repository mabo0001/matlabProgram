% ������߷�
clear
clc
xk=[1.5,1.6];
k=2;

e=1;
eps=0.00000001;
while(e>eps)
   xk(k+1)=xk(k)-(xk(k)-xk(1))*F_target(xk(k))/(F_target(xk(k))-F_target(xk(1)));
    e=abs(F_target(xk(k+1)));
%     e=xk(k+1)-xk(k);
    k=k+1;
    plot(xk);
    xlabel('��������')
    ylabel('xk�仯')
    title('������߷�')
    
    
    
end