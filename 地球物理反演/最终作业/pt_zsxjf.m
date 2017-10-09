function [p,t]  = pt_zsxjf( rhos,lambda,M ,LayerNumber)
%�������½�������������
%   rhosΪ�۲�����
m=size(lambda,2);
%��֤ÿ�μ���ʱԭʼlambdaֵ����
for i=1:m
    e=zeros(size(lambda));
    e(i)=0.1*lambda(i);
    p(i)=(fhi(rhos,lambda+e,LayerNumber)-fhi(rhos,lambda-e,LayerNumber))/(2*e(i));
end
% t=25;
% ��Hessian����
for i=1:m
    e1=zeros(size(lambda));
    e1(i)=0.1*lambda(i);
    for j=1:m
        e2=zeros(size(lambda));
        e2(j)=0.1*lambda(j);
        H(i,j)=(fhi(rhos,lambda+e1+e2,LayerNumber)-fhi(rhos,lambda+e1-e2,LayerNumber)-fhi(rhos,lambda+e2-e1,LayerNumber)+fhi(rhos,lambda-e1-e2,LayerNumber))/(4*e1(i)*e2(j));
    end
end
% 
%�Ż�Hessian����
H=H+M*eye(size(H));
% %����������t
t=(p*p')./(p*H*p');

end

