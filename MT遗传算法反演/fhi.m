function f = fhi( rhos,lambda )
%反演目标函数
%   rhos为观测数据，lambda为模型参数
f=norm(log10(rhos)-log10(mt1d(lambda)));

end

