function [ sk,u ] = ub1( nd1,nb1,u1,nd,iw ,sk)
%带入第一类边界条件
% nd1,第一类边界条件的节点数
% nb1,第一类边界条件的节点号
% u1,第一类边界节点的场值
% nd,节点总数
% iw,半带宽
% sk,输入时为半带宽存放的总体系数矩阵，输出时，第一类边界条件已经带入
% u ，加第一类边界条件后的右端列向量
%   此处显示详细说明

for i=1:nd
    u(i)=0;
end
for i=1:nd1
    j=nb1(i);
    sk(j,iw)=sk(j,iw)*(10^10);
    u(j)=sk(j,iw)*u1(i);
end
end

