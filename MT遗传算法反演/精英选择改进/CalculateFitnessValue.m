function [ FitnessValue ] = CalculateFitnessValue( TargetFunctionValue )
%������ֵ
%   �˴���ʾ��ϸ˵��
% FMax=max(TargetFunctionValue);
for i=1:size(TargetFunctionValue,1)
%     FitnessValue(i)=FMax-TargetFunctionValue(i);
FitnessValue(i)=1/abs(TargetFunctionValue(i));
end
FitnessValue=FitnessValue';
end

