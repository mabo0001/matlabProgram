function sk = uk1( nd,ne,iw,i3,xy)
%求总体系数矩阵K
% nd,节点总数
% ne,单元总数
% iw,半带宽
% i3,单元节点编号
% xy，节点坐标
% sk，总体系数矩阵
%   此处显示详细说明
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

