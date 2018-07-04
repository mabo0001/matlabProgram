clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%                             大地电磁二维限元正演（TE模式）
%                   
%                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u=4*pi*10^(-7);                               % 空气中的磁导率
%Z0=[10000,5000,2000,1000,500];         % 空气层
Z0=[10000,5000,3000,2000,1000,500,200,100];         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  数据读取 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                             
f=load('frequency');                                                                 %%
node=load('nodemodel');                                                              %%
survey=load('surveymodel');     sp=survey;    [Np,cc]=size(sp);                      %%
body=load('bodymodle'); sc=struct2cell(body); p=cell2mat(sc);                        %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  网格参数  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=node(2:node(1,1)+1,1)';                                                            %%
Z=node(2:node(1,2)+1,2)';    Z=[Z0,Z];     NK=length(Z0);                            %%                                                                          
[cc,Nx]=size(X);       [cc,Nz]=size(Z);        [Nf,cc]=size(f);                      %%
NP=(Nx+1)*(Nz+1);                                                                    %%
Kz1=sparse(NP,NP);     Kz2=sparse(NP,NP);      Kz3=sparse(NP,NP);                    %%
[cb,cc]=size(body);    [cs,cc]=size(survey);                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 求刚度系数矩阵 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w0=2*pi*1;  
pp=100;                                                    % 半空间（背景电阻率值）
tic
t=1/(i*w0*u);
p=[10^4*ones(NK,Nx);p];
for h=1:Nx
    for j=1:Nz
        k=1/p(j,h);
        a=(h-1)*(Nz+1)+j;          b=(h-1)*(Nz+1)+j+1;
        c=(h-1)*(Nz+1)+j+(Nz+1)+1; e=c-1;
        K1=Ke1(X(h),Z(j),t);  K2=Ke2(X(h),Z(j),k);
        Kz1=Kz1+KK1(a,b,c,e,K1,NP);
        Kz2=Kz2+KK1(a,b,c,e,K2,NP);
        if(j==Nz)
            kk=sqrt((-i*w0*u)/pp);
            K3=Ke3(Z(j),kk,t);
            Kz3=Kz3+KK1(a,b,c,e,K3,NP);
        end  
    end
end
toc
Ue=zeros(NP,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for r=1:Nf
    B=zeros(1,NP);
    w=2*pi*f(r);
    K=(1/f(r))*Kz1-Kz2+sqrt(f(r))*(1/f(r))*Kz3;
    for x=1:(Nx+1)
        y=(x-1)*(Nz+1)+1; K(y,y)=K(y,y)*10^10; B(1,y)=K(y,y)*10^10;
    end
    [L1,U1]=luinc(K,1);
    Ue=bicgstab(K,B',1e-15,800,L1,U1,Ue); % 不完全LU分解，稳定双共轭梯度法求解线性方程组
    L=Z(1+NK)+Z(2+NK)+Z(3+NK);
    for m=1:Np
       n=(sp(m)-1)*(Nz+1)+1+NK;
       de(m)=(1/(2*L))*((-11)*Ue(n,1)+18*Ue(n+1,1)+(-9)*Ue(n+2,1)+2*Ue(n+3,1));
       pe(r,m)=abs(-i*w*u*(Ue(n,1)/de(m))^2);
       qe(r,m)=90+atan(imag(Ue(n,1)*i*w*u/de(m))/real(Ue(n,1)*i*w*u/de(m)))*(360/(2*pi));
    end
end
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  画图  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sp=[-10000,-9000,-8000,-7000,-6000,-5000,-4000,-3000,-2000,-1000,0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];
[X,Y]=meshgrid(Sp',log10(f));
subplot(1,2,1);
[c,h]=contourf(X,Y,pe,100);
set(h,'LineStyle','none');%去掉等值线，只留渐变颜色
xlabel('里程（m）');
ylabel('log10(f)/Hz');
subplot(1,2,2);
[c,h]=contourf(X,Y,qe,100);
set(h,'LineStyle','none');%去掉等值线，只留渐变颜色
xlabel('里程（m）');
ylabel('log10(f)/Hz');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 保存数据 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result=[Nf*Np,Nf,Np];
for j=1:Np
   result=[result;f,pe(:,j),qe(:,j)];
end
D1=fopen('resultTE.dat','wt');
fprintf(D1,'%.6d     %.2d   %.2d\n',result');
fclose(D1);                      %  结果

%   保存结果中第一行数据：第一个为数据个数，第二个位频点数，第三个为测点数
%   从第二行开始，第一列为频率，第二列为电阻率，第三列为相位