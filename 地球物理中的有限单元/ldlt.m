function [p,ie ] = ldlt( a,n,iw,p )
%解半带宽存储矩阵方程
% a,存放对称带型方程组系数矩阵的下三角部分
% n,方程组阶数
% iw,半带宽
% p开始存放方程组右侧向量，结束时存放解向量
% ie，为0表示程序正常结束，为1表示系数矩阵奇异
%   此处显示详细说明

for i=1:n
    if(i<=iw)
        it=1;
    else
        it=i-iw+1;
    end
    k=i-1;
    if(i==1)
        if(a(i,iw)==0)
            ie=1;
        end
    else
        for l=it:k
            il=l+iw-i;
            b=a(i,il);
            a(i,il)=b/a(l,iw);
            p(i)=p(i)-a(i,il)*p(l);
            mi=l+1;
            for j=mi:i
                ij=j+iw-i;
                jl=l+iw-j;
                a(i,ij)=a(i,ij)-a(j,jl)*b;
            end
             if(a(i,iw)==0)
                 ie=1;
             end
        end
    end
end
        for j=1:n
            if(j<=iw)
                it=n;
            else
                it=n-j+iw;
            end
            i=n-j+1;
            p(i)=p(i)/a(i,iw);
            if(j==1)
                continue;
            else
                k=i+1;
                for mj=k:it
                    ij=i-mj+iw;
                    p(i)=p(i)-p(mj)*a(mj,ij);
                end
            end
        end
        ie=0;
end
