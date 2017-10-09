function [ T ] = CompositeTrapezoidalIntegrate( a,b,N )
%�������ι�ʽ�����
%   a��b���������ޣ�FĿ�꺯����N,�ڵ���
% TΪ����ֽ��
x=linspace(a,b,N);
h=(x(N)-x(1))/N;
sum=0;
for k=1:N-1
    sum=sum+F_target(x(k))+F_target(x(k+1));
end
T=(h/2)*sum;

end

