function [ y ] = F_target(  rhos,lambda,LayerNumber ,xx,yy)
%Ŀ�꺯��
%   �˴���ʾ��
y=norm(log2(rhos)-log2(WFEM_forward(lambda(1:LayerNumber) ,lambda(LayerNumber+1:end),xx,yy )));
end

