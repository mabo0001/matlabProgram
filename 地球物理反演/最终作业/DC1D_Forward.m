function [rho_s]=DC1D_Forward(rho1,h1)
%一维直流电测深正演函数主文件
global rho;
global h;
rho=rho1;
h=h1;
r=logspace(1,4,40);
% r=linspace(0,0.72,36);
    for i=1:size(r,2)
        z(i)=hankel1_47('Transfer_Fun',r(i));
        rho_s(i)=r(i)*r(i)*z(i);
    end
end
