clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%                             ��ص�Ŷ�ά��Ԫ���ݣ�THģʽ��
%                   
%                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u=4*pi*10^(-7);                               % �����еĴŵ���
Z0=[10000,5000,3000,2000,1000,500,200,100]; 
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ���ݶ�ȡ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                             
f=load('frequency');                                                                 %%
node=load('nodemodel');                                                              %%
survey=load('surveymodel');     sp=survey;    [Np,cc]=size(sp);                      %%
body=load('bodymodle'); sc=struct2cell(body); t=cell2mat(sc);                        %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  �������  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=node(2:node(1,1)+1,1)';                                                            %%
Z=node(2:node(1,2)+1,2)';                                                            %%                                                                          
[cc,Nx]=size(X);       [cc,Nz]=size(Z);        [Nf,cc]=size(f);                      %%
NP=(Nx+1)*(Nz+1);                                                                    %%
Kz1=sparse(NP,NP);     Kz2=sparse(NP,NP);      Kz3=sparse(NP,NP);                    %%
[cb,cc]=size(body);    [cs,cc]=size(survey);                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��ն�ϵ������ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w0=2*pi*1;  
pp=t(Nz,1);                                                       % ��ռ䣨����������ֵ��
tic
k=i*w0*u;
for h=1:Nx
    for j=1:Nz
        a=(h-1)*(Nz+1)+j;          b=(h-1)*(Nz+1)+j+1;
        c=(h-1)*(Nz+1)+j+(Nz+1)+1; e=c-1;
        K1=Ke1(X(h),Z(j),t(j,h));  K2=Ke2(X(h),Z(j),k);
        Kz1=Kz1+KK1(a,b,c,e,K1,NP);
        Kz2=Kz2+KK1(a,b,c,e,K2,NP);
        if(j==Nz)
            kk=sqrt((-i*w0*u)/pp);
            K3=Ke3(Z(j),kk,t(j,h));
            Kz3=Kz3+KK1(a,b,c,e,K3,NP);
        end  
    end
end
toc
Uh=zeros(NP,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for r=1:Nf
    B=zeros(1,NP);
    w=2*pi*f(r);
    K=Kz1-f(r)*Kz2+sqrt(f(r))*Kz3;
    for x=1:(Nx+1)
        y=(x-1)*(Nz+1)+1; K(y,y)=K(y,y)*10^10; B(1,y)=K(y,y)*10^10;
    end
    [L1,U1]=luinc(K,1);Uh=bicgstab(K,B',1e-15,800,L1,U1,Uh); % ����ȫLU�ֽ⣬�ȶ�˫�����ݶȷ�������Է�����
    L=Z(1)+Z(2)+Z(3);
    for m=1:Np
       n=(sp(m)-1)*(Nz+1)+1;
       dh(m)=(1/(2*L))*((-11)*Uh(n,1)+18*Uh(n+1,1)+(-9)*Uh(n+2,1)+2*Uh(n+3,1));
       ph(r,m)=abs(((t(1,sp(m)))^2*i)/(w*u)*(dh(m)/Uh(n,1))^2);
       qh(r,m)=atan(imag(dh(m)/Uh(n,1))/real(dh(m)/Uh(n,1)))*(360/(2*pi))+90;
    end
end
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ��ͼ  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sp=[-10000,-9000,-8000,-7000,-6000,-5000,-4000,-3000,-2000,-1000,0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];
[X,Y]=meshgrid(Sp',log10(f));
subplot(1,2,1);
[c,h]=contourf(X,Y,ph,100);
set(h,'LineStyle','none');%ȥ����ֵ�ߣ�ֻ��������ɫ
xlabel('��̣�m��');
ylabel('log10(f)/Hz');
subplot(1,2,2);
[c,h]=contourf(X,Y,qh,100);
set(h,'LineStyle','none');%ȥ����ֵ�ߣ�ֻ��������ɫ
xlabel('��̣�m��');
ylabel('log10(f)/Hz');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% �������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result=[Nf*Np,Nf,Np];
for j=1:Np
   result=[result;f,ph(:,j),qh(:,j)];
end
D1=fopen('resultTH.dat','wt');
fprintf(D1,'%.6d     %.2d   %.2d\n',result');
fclose(D1);                      %  ���

%   �������е�һ�����ݣ���һ��Ϊ���ݸ������ڶ���λƵ������������Ϊ�����
%   �ӵڶ��п�ʼ����һ��ΪƵ�ʣ��ڶ���Ϊ�����ʣ�������Ϊ��λ