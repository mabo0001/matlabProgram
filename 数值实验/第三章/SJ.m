clear
clc
N=1000;
a=0;
b=pi;
[ T ] = CompositeSimpsonIntegrate(  a,b,N )
% x=linspace(a,b,N);
% f= F_target( x );
% h=(x(N)-x(1))/N;
% 
% sum=0;
% for k=1:N-1
%     sum=sum+F_target(x(k))+4*F_target(x(k)+0.5*h)+F_target(x(k+1));
% end
% T=(h/6)*sum;