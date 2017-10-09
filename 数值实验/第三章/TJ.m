clear
clc
N=1000;
a=0;
b=pi;
% x=linspace(0,pi,N);
T = CompositeTrapezoidalIntegrate( a,b,N )
% f= F_target( x );
% h=(x(N)-x(1))/N;
% sum=0;
% for k=1:N-1
%     sum=sum+F_target(x(k))+F_target(x(k+1));
% end
% T=(h/2)*sum;

