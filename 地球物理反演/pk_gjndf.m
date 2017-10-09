function p = pk_gjndf(  rhos,lambda  ,M)
%求改进牛顿法搜索方向
%   此处显示详细说明

m=size(lambda,2);
%保证每次计算时原始lambda值不变
for i=1:m
    e=zeros(size(lambda));
    e(i)=0.1*lambda(i);
    df(i)=(fhi(rhos,lambda+e)-fhi(rhos,lambda-e))/(2*e(i));
end

% t=25;
%求Hessian矩阵
for i=1:m
    e1=zeros(size(lambda));
    e1(i)=0.1*lambda(i);
    for j=1:m
        e2=zeros(size(lambda));
        e2(j)=0.1*lambda(j);
        H(i,j)=(fhi(rhos,lambda+e1+e2)-fhi(rhos,lambda+e1-e2)-fhi(rhos,lambda+e2-e1)+fhi(rhos,lambda-e1-e2))/(4*e1(i)*e2(j));
    end
end

% %求搜索步长t
% H
%优化Hessian矩阵
H=H+M*eye(size(H));

p=-inv(H)*df';


end

