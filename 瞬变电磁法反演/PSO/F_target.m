function [ y ] = F_target(  rhos,lambda,LayerNumber)
%目标函数
%   此处显示详
y=norm(log2(rhos)-log2(TEM1D_forward(lambda(1:LayerNumber) ,lambda(LayerNumber+1:end))));
end

