function sk = uk1( nd,ne,iw,i3,xy)
%������ϵ������K
% nd,�ڵ�����
% ne,��Ԫ����
% iw,�����
% i3,��Ԫ�ڵ���
% xy���ڵ�����
% sk������ϵ������
%   �˴���ʾ��ϸ˵��
for i=1:nd
    for j=1:iw
        sk(i,j)=0;
    end
end
for l=1:ne
    for j=1:3
        i=i3(j,l);
        x(j)=xy(1,i);
        y(j)=xy(2,i);
    end
    ke = uke1( x,y );
    for j=1:3
        nj=i3(j,l);
        for k=1:j
            nk=i3(k,l);
            if(nj<nk)
                nj=nj-nk+iw;
                sk(nk,nj)=sk(nk,nj)+ke(j,k);
                nj=nj+nk-iw;
            else
                nk=nk-nj+iw;
                sk(nj,nk)=sk(nj,nk)+ke(j,k);
            end
        end
    end
end


end

