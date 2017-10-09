function [ T ] = CompositeTrapezoidalIntegrate( a,b,N )
%复化梯形公式求积分
%   a，b坐标上下限，F目标函数，N,节点数
% T为求积分结果
x=linspace(a,b,N);
h=(x(N)-x(1))/N;
sum=0;
for k=1:N-1
    sum=sum+F_target(x(k))+F_target(x(k+1));
end
T=(h/2)*sum;

end

