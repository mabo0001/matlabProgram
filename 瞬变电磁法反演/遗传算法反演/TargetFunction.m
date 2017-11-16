function [ TargetFunctionValue ] = TargetFunction( rhos,Population1st,length,a,b,LayerNumber )
%目标函数
%   此处显示详细说明

% Population1st解码
% rho1=10+(1000-10)* Decode( Population1st ,1,10)/(2^10-1);
% rho2=10+(1000-10)* Decode( Population1st ,11,10)/(2^10-1);
% rho3=10+(1000-10)* Decode( Population1st ,21,10)/(2^10-1);
% h1= 100+(5000-100)*Decode( Population1st ,31,12)/(2^12-1);
% h2=100+(5000-100)* Decode( Population1st ,43,12)/(2^12-1);
% rho_i=[rho1,rho2,rho3];
% % h_i=[h1,h2];
% x=0;
% y=10000;

[ lambda ] = DecodeToModel( Population1st,length,a,b );
% [ lambda ] = DecodeToModel( Population1st,[10,10,10,12,12] );

for i=1:size(Population1st,1)
    TargetFunctionValue(i)=norm(log2(rhos)-log2(TEM1D_forward( lambda(i,1:LayerNumber),lambda(i,LayerNumber+1:end))));
end
TargetFunctionValue=TargetFunctionValue';

end

