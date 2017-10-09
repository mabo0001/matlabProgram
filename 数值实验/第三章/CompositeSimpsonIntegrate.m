function [ T ] = CompositeSimpsonIntegrate(  a,b,N )
%����Simpson��ʽ
%   �˴���ʾ��ϸ˵��
x=linspace(a,b,N);
h=(x(N)-x(1))/N;

sum=0;
for k=1:N-1
    sum=sum+F_target(x(k))+4*F_target(x(k)+0.5*h)+F_target(x(k+1));
end
T=(h/6)*sum;

end

