function [gravity]=ele_gravity(num_ele,p,eledata,nodedata,l,kx,ky,kz);

% V:1--Vxx;2--Vxy;3--Vxz,4--Vyy,5--Vyz;6--Vzz

G=6.67*10^(-11);

[SO] = dir_vevtor(num_ele,eledata,nodedata);

[XYZ] = Rotate(num_ele,eledata,nodedata,SO);

[K123] = mian_Ki(SO,XYZ,1,kx,ky,kz);

[K234] = mian_Ki(SO,XYZ,2,kx,ky,kz);

[K341] = mian_Ki(SO,XYZ,3,kx,ky,kz);

[K412] = mian_Ki(SO,XYZ,4,kx,ky,kz);

gravity = G*p*(l*SO(1,:)'*K123+l*SO(2,:)'*K234+l*SO(3,:)'*K341+l*SO(4,:)'*K412);