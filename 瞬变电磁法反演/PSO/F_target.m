function [ y ] = F_target(  rhos,lambda,LayerNumber)
%Ŀ�꺯��
%   �˴���ʾ��
y=norm(log2(rhos)-log2(TEM1D_forward(lambda(1:LayerNumber) ,lambda(LayerNumber+1:end))));
end

