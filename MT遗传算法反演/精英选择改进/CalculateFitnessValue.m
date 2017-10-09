function [ FitnessValue ] = CalculateFitnessValue( TargetFunctionValue )
%计算适值
%   此处显示详细说明
% FMax=max(TargetFunctionValue);
for i=1:size(TargetFunctionValue,1)
%     FitnessValue(i)=FMax-TargetFunctionValue(i);
FitnessValue(i)=1/abs(TargetFunctionValue(i));
end
FitnessValue=FitnessValue';
end

