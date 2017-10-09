function t = t_gjnd(rhos,lambda,M ,LayerNumber)
%改进牛顿法求步长
%   此处显示详细说明
m=size(lambda,2);
% 保证每次计算时原始lambda值不变
for i=1:m
    e=zeros(size(lambda));
    e(i)=0.1*lambda(i);
    p(i)=(fhi(rhos,lambda+e,LayerNumber)-fhi(rhos,lambda-e,LayerNumber))/(2*e(i));
end

%求Hessian矩阵
for i=1:m
    e1=zeros(size(lambda));
    e1(i)=0.001*lambda(i);
    for j=1:m
        e2=zeros(size(lambda));
        e2(j)=0.001*lambda(j);
        H(i,j)=(fhi(rhos,lambda+e1+e2,LayerNumber)-fhi(rhos,lambda+e1-e2,LayerNumber)-fhi(rhos,lambda+e2-e1,LayerNumber)+fhi(rhos,lambda-e1-e2,LayerNumber))/(4*e1(i)*e2(j));
    end
end
%优化Hessian矩阵
H=H+M*eye(size(H));
% %求搜索步长t
t=(p*p')./(p*H*p');

end

