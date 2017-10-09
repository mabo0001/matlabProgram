% 龙贝格积分romberg积分
clear
clc
a=0.0001;
b=1;
k=1;
i=1;
% M=1;
T(1,1)=(F_target(a)+F_target(b))*(b-a)/2;
T(2,1)=0.5*T(1,1)+F_target((a+b)/2)*(b-a)/2;
T(1,2)=(4*T(2,1)-T(1,1))/3;
e=1;
while(e>0.001)
    
    k=k+1;
    
    T(k+1,1)=0.5*T(k,1)+RombergSum( a,b,2^(k-1) );
    for j=1:k
        T(k+1-j,j+1)=((4^j)*T(k+2-j,j)-T(k+1-j,j))/(4^j-1);
    end
    e=abs(T(1,end)-T(1,end-1));
end
T(1,3)
