clc; clear;

load('ydata.mat');

load('yVzz.mat','Vzz');

Vzz = Vzz;

% Vzz = reshape(Vzz,441,1);

nCoef = 9;

Vzz = Vzz*10^nCoef;

load('yGzz.mat','Gij');

Gij = Gij*10^nCoef;

a =1e5*10;%1e3*0.9;

Nd = size(Vzz,1);

MM = 0.002*max(Vzz);

Wdd=random('Normal',0,MM,Nd,1);

%  Wdd = 0;

Vzz = Vzz+Wdd;

Wd = eye(Nd,Nd)/MM; 

Wd = sparse(Wd);

 
 [Wz] = W_Wz(nodedata,eledata);

% Nm = size(eledata,1);

%Wz = eye(Nm);

[point] = zhongxin(nodedata,eledata);

[V]=tiji(eledata,nodedata);

% ax = 1; ay = 1; az = 1; as = 0;

[L] = chafen1(neighdata,V,point);

Wm_Wm = sparse(Wz'*L*Wz);

m = rand(size(Gij,2),1)*1e-3;

% Gij =Gij*Wz';

% clear V L point Wdd MM Nd nCoef nodedata neighdata eledata facedata

A = Gij'*Wd'*Wd*Gij+a*Wm_Wm;

for i = 1:20
    
    deta_d_k = Vzz-Gij*m;
            
    b1= Gij'*Wd'*Wd*deta_d_k-a*Wm_Wm*m;
    
    tol = 1e-10;
    
    maxit = 40;
    
    %   M1 = spdiags(1./(spdiags(Wz)),0,Nm,Nm);
     M1 = Wz;
    
    [x1,flag1,rr1,iter1,rv1] = pcg(A,b1,tol,maxit,M1);
    
    m = x1+m;
    
    misfit = (Vzz-Gij*m)'*Wd'*Wd*(Vzz-Gij*m)
    
    mor = m'*Wm_Wm'*m
    
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

 figure;plot(Gij*p);


