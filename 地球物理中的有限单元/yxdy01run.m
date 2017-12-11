clear
clc
nd=15;%节点数
ne=16;%单元数
% 单元节点编号
i3=[1,5,5,5,5,5,5,8,11,8,8,8,10,11,11,11;4,2,3,6,4,7,8,9,7,7,11,12,13,10,14,15;2,4,2,3,7,8,6,6,10,11,12,9,14,14,15,12];
%节点坐标
xy=[0,0,0,1,1,1,2, 2,2,3,3,3,4,4,4;0,1,2,0.5,1.2,2,1,1.5,2,0.7,1.3,2,0.5,1.2,2];
%边界条件
nd1=12;
nb1=[1,2,3,4,6,7,9,10,12,13,14,15];
u1=[1,0.5,0.33,0.46,0.3,0.25,0.23,0.14,0.17,0.08,0.11,0.12];
%求半带宽
iw = mbw( ne,i3 );
% 半带宽存储的总体系数矩阵
sk = uk1( nd,ne,iw,i3,xy);
%乘大数法带入第一类边界条件
[ sk,u ] = ub1( nd1,nb1,u1,nd,iw ,sk);
% 半带宽矩阵转换为全矩阵
K=sk2k(sk,iw)
% Doolittle LU分解求解方程组
[ L_Doolittle,U_Doolittle,y_Doolittle,x_Doolittle ]=LU_Doolittle(K,2*u);

%改进Cholesky分解解方程
[ L_Cholesky,d_Cholesky,y_Cholesky,x_Cholesky ] = CholeskyOptimize( K,2*u' );

%书上半带宽标准求解 解方程
[p,ie ] = ldlt( sk,nd,iw,u );
%输出
xyu=[xy;p]'
