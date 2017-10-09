function [ y ] = F_target(  rhos,lambda,LayerNumber ,xx,yy)
%目标函数
%   此处显示详
y=norm(log2(rhos)-log2(WFEM_forward(lambda(1:LayerNumber) ,lambda(LayerNumber+1:end),xx,yy )));
end

