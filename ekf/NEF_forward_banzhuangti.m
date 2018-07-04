function [ V ] = NEF_forward_banzhuangti(  x,alpha,z,x0,I,rho,L )
% 倾斜板状体模型自然电场法一维正演函数
%   x x向采样位置
%  alpha 倾斜板状体的倾斜角度
% z 板状体中心埋藏元深度
% x0  异常元坐标
% rho 介质电阻率
% I 单位长度上的电流
% L 倾斜板状体长度的1/2

K_BZT=I*rho/(2*pi);
A=(x-x0);
B=L*cos(alpha);
C=L*sin(alpha);

D=((A-B).^2+(z-C).^2)./((A+B).^2+(z+C).^2);

V=K_BZT.*log(D);

end

