function [ FitnessValue ] = CalculateFitnessValue( V,x,lambda )
%   计算适値
%   此处显示详细说明
% z=(lambda(:,1).^2+lambda(:,2).^2+lambda(:,3).^2);
FitnessValue=1./F_target(  V,x,lambda );
% FitnessValue=1./z;

end

