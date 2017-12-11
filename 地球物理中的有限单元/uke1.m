function ke = uke1( x,y )
%求单元系数矩阵Ke
% xy节点坐标矩阵，ke单元系数矩阵
%   此处显示详细说明
a(1)=y(2)-y(3);
a(2)=y(3)-y(1);
a(3)=y(1)-y(2);
b(1)=x(3)-x(2);
b(2)=x(1)-x(3);
b(3)=x(2)-x(1);
s=2*(a(1)*b(2)-a(2)*b(1));
for i=1:3
    for j=1:i
        ke(i,j)=(a(i)*a(j)+b(i)*b(j))/s;
    end
end
end
