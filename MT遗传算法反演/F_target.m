function [ y ] = F_target(  rhos,lambda )
%目标函数
%   此处显示详
% y=norm(log10(rhos)-log10(mt1d(lambda)));
y=norm(log2(rhos)-log2(mt1d(lambda)));
end

