clc; clear;
% data 12
load('ydata.mat');

load('yVxx.mat','Vxx');
load('yVxy.mat','Vxy');
load('yVxz.mat','Vxz');
load('yVyy.mat','Vyy');
load('yVyz.mat','Vyz');
load('yVzz.mat','Vzz');

Vzz = Vzz;

% Vzz = reshape(Vzz,441,1);

nCoef = 9;

Vxx = Vxx*10^nCoef;
Vxy = Vxy*10^nCoef;
Vxz = Vxz*10^nCoef;
Vyy = Vyy*10^nCoef;
Vyz = Vyz*10^nCoef;
Vzz = Vzz*10^nCoef;

load('yGxx.mat','Gij');
Gxx = Gij*10^nCoef;
load('yGxy.mat','Gij');
Gxy = Gij*10^nCoef;
load('yGxz.mat','Gij');
Gxz = Gij*10^nCoef;
load('yGyy.mat','Gij');
Gyy = Gij*10^nCoef;
load('yGyz.mat','Gij');
Gyz = Gij*10^nCoef;
load('yGzz.mat','Gij');
Gzz = Gij*10^nCoef;
clear Gij;

a =1e5*10;%1e3*0.9;

Nd= size(Vxx,1);
%%

MMxx = 0.002*max(Vxx);

Wddxx=random('Normal',0,MMxx,Nd,1);

Vxx = Vxx+Wddxx;

Wdxx = eye(Nd,Nd)/MMxx; 

Wdxx = sparse(Wdxx);
%%
MMxy = 0.002*max(Vxy);

Wddxy=random('Normal',0,MMxy,Nd,1);

Vxy = Vxy+Wddxy;

Wdxy= eye(Nd,Nd)/MMxy; 

Wdxy = sparse(Wdxy);
%%

MMyy = 0.002*max(Vyy);

Wddyy=random('Normal',0,MMyy,Nd,1);

Vyy = Vyy+Wddyy;

Wdyy= eye(Nd,Nd)/MMyy; 

Wdyy = sparse(Wdyy);
%%
MMxz = 0.002*max(Vxz);

Wddxz=random('Normal',0,MMxz,Nd,1);

Vxz = Vxz+Wddxz;

Wdxz = eye(Nd,Nd)/MMxz; 

Wdxz = sparse(Wdxz);
%%

MMyz = 0.002*max(Vyz);

Wddyz=random('Normal',0,MMyz,Nd,1);

Vyz = Vyz+Wddyz;

Wdyz= eye(Nd,Nd)/MMyz; 

Wdyz = sparse(Wdyz);
%%
MMzz = 0.002*max(Vzz);

Wddzz=random('Normal',0,MMzz,Nd,1);

Vzz = Vzz+Wddzz;

Wdzz= eye(Nd,Nd)/MMzz; 

Wdzz = sparse(Wdzz);
%%
clear MMxx Wddxx MMxy Wddxy MMxz Wddxz MMyy Wddyy MMyz Wddyz MMzz Wddzz
 
[Wz] = W_Wz(nodedata,eledata);

% Nm = size(eledata,1);

%Wz = eye(Nm);

[point] = zhongxin(nodedata,eledata);

[V]=tiji(eledata,nodedata);

% ax = 1; ay = 1; az = 1; as = 0;

[L] = chafen1(neighdata,V,point);

Wm_Wm = sparse(Wz'*L*Wz);

m = rand(size(Gzz,2),1)*1e-3;

% Gij =Gij*Wz';

% clear V L point Wdd MM Nd nCoef nodedata neighdata eledata facedata

% A = Gij'*Wd'*Wd*Gij+a*Wm_Wm;

A = Gxx'*Wdxx'*Wdxx*Gxx+Gxy'*Wdxy'*Wdxy*Gxy+Gxz'*Wdxz'*Wdxz*Gxz+Gyy'*Wdyy'*Wdyy*Gyy+...
    Gyz'*Wdyz'*Wdyz*Gyz+Gzz'*Wdzz'*Wdzz*Gzz+a*Wm_Wm;

for i = 1:20
    i
%     deta_d_k = Vzz-Gij*m;
            
%     b1= Gij'*Wd'*Wd*deta_d_k-a*Wm_Wm*m;
    
    b1= Gxx'*Wdxx'*Wdxx*(Vxx-Gxx*m)+Gxy'*Wdxy'*Wdxy*(Vxy-Gxy*m)+Gxz'*Wdxz'*Wdxz*(Vxz-Gxz*m)+...
        Gyy'*Wdyy'*Wdyy*(Vyy-Gyy*m)+Gyz'*Wdyz'*Wdyz*(Vyz-Gyz*m)+Gzz'*Wdzz'*Wdzz*(Vzz-Gzz*m)+-a*Wm_Wm*m;
    
    tol = 1e-10;
    
    maxit = 40;
    
    %   M1 = spdiags(1./(spdiags(Wz)),0,Nm,Nm);
     M1 = Wz;
    
    [x1,flag1,rr1,iter1,rv1] = pcg(A,b1,tol,maxit,M1);
    
    m = x1+m;
    
%     misfit = (Vzz-Gij*m)'*Wd'*Wd*(Vzz-Gij*m)
    
%     mor = m'*Wm_Wm'*m
    
end

% load('data11.mat');
% %
%% huatu

p = m;

eledata1 =[];

loop = 0;

aa = 0;

bb = 0;

p1 =[];

for i = 1:size(eledata,1)
    
    bb=0;
    
    for j = 1:4
        
        aa = (nodedata(eledata(i,j),1)>500); %||   nodedata(eledata(i,j),2)>1000   || nodedata(eledata(i,j),3)>1000);
        
        bb = bb+aa;
        
        if   bb == 4
            loop =loop+1;
            
            eledata1(loop,:) =eledata(i,:);
            
            p1(loop)=p(i);
            
        end
        
    end    
    
end

alpha =1;

figure(1);clf;
a = patch('Faces',eledata1(:,1:3),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p1','CDataMapping','scaled');

hold on

a = patch('Faces',eledata1(:,2:4),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p1','CDataMapping','scaled');

a = patch('Faces',eledata1(:,[1 2 4]),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p1','CDataMapping','scaled');

a = patch('Faces',eledata1(:,[1 3 4]),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p1','CDataMapping','scaled');

a = patch('Faces',eledata1(:,1:4),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p1','CDataMapping','scaled');

axis image

axis equal

% view(3);
 view([-105,15]);

axis([0 1000 0 1000 0 500]);
set(gca,'zdir','reverse')
set(gca,'ydir','reverse')
set(gca,'XTick',0:200:1000);set(gca,'YTick',0:200:1000);set(gca,'ZTick',0:100:500);
set(gca,'XTickLabel',{'0' '200' '400' '600'  '800' '1000' },'FontName','Times New Roman','fontsize',13);
set(gca,'YTickLabel',{'0' '200' '400' '600'  '800' ' ' },'FontName','Times New Roman','fontsize',13);
set(gca,'ZTickLabel',{'0' '100' '200' '300'  '400' '500' },'FontName','Times New Roman','fontsize',13);

xlabel('\itx\rm/m','FontName','Times New Roman','fontsize',13);
ylabel('\ity\rm/m','FontName','Times New Roman','fontsize',13);
zlabel('\itz\rm/m','FontName','Times New Roman','fontsize',13);
% set(h,'FontName','Times New Roman','FontSize',15);
% text(50,1000,100,'(f)','FontName','Times New Roman','FontSize',13,'BackgroundColor','w');
aa=colorbar;
set(get(aa,'xlabel'),'string','\it\rho \rm(g/cm^{\fontsize{10}3})','FontName','Times New Roman','fontsize',13); % colorbar��λ
set(aa,'FontName','Times New Roman','FontSize',13);
% 
% 
% 
eledata2 =[];

loop = 0;

aa = 0;

bb = 0;

p2 =[];

for i = 1:size(eledata,1)
    
    bb=0;
    
    for j = 1:4
        
        aa = (nodedata(eledata(i,j),3)>250); %||   nodedata(eledata(i,j),2)>1000   || nodedata(eledata(i,j),3)>1000);
        
        bb = bb+aa;
        
        if   bb == 4
            
            loop =loop+1;
            
            eledata2(loop,:) =eledata(i,:);
            
            p2(loop)=p(i);
            
        end
        
    end    
    
end

alpha =1;

figure(2);clf;

a = patch('Faces',eledata2(:,1:3),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p2','CDataMapping','scaled');
hold on
a = patch('Faces',eledata2(:,2:4),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p2','CDataMapping','scaled');


a = patch('Faces',eledata2(:,1:4),'Vertices',nodedata(:,1:3),'FaceAlpha',alpha,'FaceColor','flat','FaceVertexCData',p2','CDataMapping','scaled');

axis image

axis equal

view(3);

 set(gca,'zdir','reverse')

%  figure;plot(Gij*p);


