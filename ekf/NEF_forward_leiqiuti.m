function [V ] = NEF_forward_leiqiuti( x,theta,q,z,x0,r0,rho_1,rho_2,DU0 )
% ������ģ����Ȼ�糡��һά���ݺ���
%   x x�����λ��
%  theta �����Ƕ�
%  q ��״���ӣ�1.5,1,0.5 �ֱ��ʾ���壬ˮƽԲ���壬����Բ����
% z ���Ԫ���
% x0  �쳣Ԫ����
% r0 ����뾶
% rho_1 ���ʵ�����
% rho_2 ���������
% DU0 ˫����λ��
% K_LQT ������װ��ϵ��

K_LQT=-(2*rho_1*r0*r0*DU0)/(2*rho_2+rho_1);
V=K_LQT.*((x-x0).*cos(theta)+z.*sin(theta))./(((x-x0).^2+z.^2).^q);



end

