function Xmish=MT2Dmesh(X,Z,Sp,pp,body,n,m)

% 模型整合，并保存节点信息以及各网格体电阻率信息等
[cc,Nx]=size(X);[cc,Nz]=size(Z);[Nb,cc]=size(body);[cc,Ns]=size(Sp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  下段程序为边界扩展 %%%%%%%%%%%%%%%%%%%%%%%%
if n~=0
    Xq=X(1)-X(2);Xz=X(Nx)-X(Nx-1);
    for j=1:n
        if j==1
            Xlift(j)=m^(j-1)*Xq+X(1);
            Xright(j)=m^(j-1)*Xz+X(Nx);
        else
            Xlift(j)=Xlift(j-1)+m^(j-1)*Xq;
            Xright(j)=Xright(j-1)+m^(j-1)*Xz;
        end
    end
    for j=1:n
        Xlift1(j)=Xlift(n-j+1);
    end
    X=[Xlift1,X,Xright];
end
Xmish=X;
%%%%%%%%%%%%%%%%  下段程序为求单元长宽高和body 所在节点   %%%%%%%%%%%%%%%%%%%
[cc,Nx]=size(X);
for n=2:Nx   
    XX(n-1)=X(n)-X(n-1);  
    for m=1:Nb
        if body(m,1)==0.01;
            B(m,1)=1;
        end
        if body(m,1)==X(n-1);
            B(m,1)=n-1;
        end
        if body(m,2)==0.01
            B(m,2)=Nx-1;
        end
        if body(m,2)==X(n-1);
            B(m,2)=n-1-1;
        end
    end
end

for n=2:Nz   
    ZZ(n-1)=Z(n)-Z(n-1);
    for m=1:Nb
        if body(m,3)==Z(n-1);
            B(m,3)=n-1;
        end
        if body(m,4)==Z(n-1);
            B(m,4)=n-1-1;
        end
        B(m,5)=body(m,5);
    end
end
%%%%%%%%%%%%%%%%%%%% 下段程序为求测点所在节点 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:Nx
    for r=1:Ns
        if Sp(r)==X(n)
            sp(r)=n;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 网格视电阻率 %%%%%%%%%%%%%%%%%%%%%%%%%%%
[cb,cc]=size(B); 
for m=1:cb
    B(m,3)=B(m,3);
    B(m,4)=B(m,4);
end
t=[pp*ones(Nz-1,Nx-1)];
for m=1:cb
    for z=1:Nz-1
        for x=1:Nx-1
            if x>=B(m,1) && x<=B(m,2) && z>=B(m,3) && z<=B(m,4)
                     t(z,x)=B(m,5);
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%% 以下程序为整合模型文件，并保存 %%%%%%%%%%%%%%%%%%%%%%%%
[cc,cx]=size(XX);[cc,cz]=size(ZZ);maxn=max(cx,cz); 
xx=[cx,XX,zeros(1,maxn-cx)]';
zz=[cz,ZZ,zeros(1,maxn-cz)]';
f1=[xx,zz]';
D1=fopen('nodemodel','wt');
fprintf(D1,'%.2d       %.2d\n',f1);
fclose(D1);                      %  保存节点模型文件

save bodymodle t;                %  保存网格电阻率信息  

f3=sp';                
D3=fopen('surveymodel','wt');
fprintf(D3,'%d\n',f3);
fclose(D3);                      % 保存测点文件
disp('===========模型文件已保存！===========');           