function [ TargetFunctionValue ] = TargetFunction( V,Population1st,length,a,b,x )
%Ä¿±êº¯Êý

[ lambda ] = DecodeToModel( Population1st,length,a,b );


for i=1:size(Population1st,1)
    theta=lambda(i,1);
    q=lambda(i,2);
    z=lambda(i,3);
    x0=lambda(i,4);
    K_LQT=lambda(i,5);
    TargetFunctionValue(i)=norm(log2(V)-log2(NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT )));
end
TargetFunctionValue=TargetFunctionValue';

end

