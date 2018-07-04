function [V ] = NEF_forward_leiqiuti( x,theta,q,z,x0,r0,rho_1,rho_2,DU0 )
% 类球体模型自然电场法一维正演函数
%   x x向采样位置
%  theta 极化角度
%  q 形状因子，1.5,1,0.5 分别表示球体，水平圆柱体，处置圆柱体
% z 埋藏元深度
% x0  异常元坐标
% r0 球体半径
% rho_1 介质电阻率
% rho_2 球体电阻率
% DU0 双电层电位差
% K_LQT 类球体装置系数

K_LQT=-(2*rho_1*r0*r0*DU0)/(2*rho_2+rho_1);
V=K_LQT.*((x-x0).*cos(theta)+z.*sin(theta))./(((x-x0).^2+z.^2).^q);



end

