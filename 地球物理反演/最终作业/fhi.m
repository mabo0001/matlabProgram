function f = fhi( rhos,lambda,LayerNumber )
%非线性反演目标函数
%   rhos为观测数据，lambda为模型参数
f=norm(log2(rhos)-log2(DC1D_Forward(lambda(1:LayerNumber),lambda(LayerNumber+1:end))));

end

