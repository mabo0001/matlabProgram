function [ TargetFunctionValue ] = TargetFunction( rhos,Population1st,length,a,b,LayerNumber )
%目标函数
%   此处显示详细说明


[ lambda ] = DecodeToModel( Population1st,length,a,b );
% [ lambda ] = DecodeToModel( Population1st,[10,10,10,12,12] );

for i=1:size(Population1st,1)
    TargetFunctionValue(i)=norm(log2(rhos)-log2(DC1D_Forward(lambda(i,1:LayerNumber),lambda(i,LayerNumber+1:end)) ));
end
TargetFunctionValue=TargetFunctionValue';

end

