function [ y ] = F_target(  V,x,lambda)
%Ä¿±êº¯Êý
theta=lambda(1);
q=lambda(2);
z=lambda(3);
x0=lambda(4);
K_LQT=lambda(5);
y=norm(log2(V)-log2(NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT )));
end

