function iw = mbw( ne,i3 )
%�����洢
% ne,��Ԫ����
% i3,3*ne�Ķ�ά���飬��ŵ�Ԫ�ڵ���
% iw,������������
%   �˴���ʾ��ϸ˵��
iw=0;
for i=1:ne
    m=max([abs(i3(1,i)-i3(2,i)),abs(i3(2,i)-i3(3,i)),abs(i3(3,i)-i3(1,i))]);
    if(m+1>iw)
        iw=m+1;
    end
end


end
