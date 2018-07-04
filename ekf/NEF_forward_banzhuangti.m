function [ V ] = NEF_forward_banzhuangti(  x,alpha,z,x0,I,rho,L )
% ��б��״��ģ����Ȼ�糡��һά���ݺ���
%   x x�����λ��
%  alpha ��б��״�����б�Ƕ�
% z ��״���������Ԫ���
% x0  �쳣Ԫ����
% rho ���ʵ�����
% I ��λ�����ϵĵ���
% L ��б��״�峤�ȵ�1/2

K_BZT=I*rho/(2*pi);
A=(x-x0);
B=L*cos(alpha);
C=L*sin(alpha);

D=((A-B).^2+(z-C).^2)./((A+B).^2+(z+C).^2);

V=K_BZT.*log(D);

end

