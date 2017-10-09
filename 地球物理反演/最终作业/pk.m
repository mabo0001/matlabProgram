function  p  = pk(rhos,lambda,LayerNumber )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
m=size(lambda,2);
%保证每次计算时原始lambda值不变
for i=1:m
    e=zeros(size(lambda));
    e(i)=0.1*lambda(i);
    p(i)=(fhi(rhos,lambda+e,LayerNumber)-fhi(rhos,lambda-e,LayerNumber))/(2*e(i));
end

% %求Hessian矩阵
% for i=1:m
%     e1=zeros(size(lambda));
%     e1(i)=0.001*lambda(i);
%     for j=1:m
%         e2=zeros(size(lambda));
%         e2(j)=0.001*lambda(j);
%         H(i,j)=(norm(log10(rhos)-log10(mt1d(lambda+e1+e2)))-norm(log10(rhos)-log10(mt1d(lambda+e1)))-...
%             norm(log10(rhos)-log10(mt1d(lambda+e2)))+norm(log10(rhos)-log10(mt1d(lambda))))/(e1(i)*e2(j));
%     end
% end
% %求搜索步长t
% H
% t=(p*p')./(p*H*p');

end

