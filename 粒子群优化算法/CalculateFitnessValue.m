function [ FitnessValue ] = CalculateFitnessValue( rhos,lambda )
%   �����ʂ�
%   �˴���ʾ��ϸ˵��
% z=(lambda(:,1).^2+lambda(:,2).^2+lambda(:,3).^2);
FitnessValue=1./F_target(  rhos,lambda );
% FitnessValue=1./z;

end

