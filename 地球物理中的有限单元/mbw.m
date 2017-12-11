function iw = mbw( ne,i3 )
%半带宽存储
% ne,单元总数
% i3,3*ne的二维数组，存放单元节点编号
% iw,输出参数半带宽
%   此处显示详细说明
iw=0;
for i=1:ne
    m=max([abs(i3(1,i)-i3(2,i)),abs(i3(2,i)-i3(3,i)),abs(i3(3,i)-i3(1,i))]);
    if(m+1>iw)
        iw=m+1;
    end
end


end
