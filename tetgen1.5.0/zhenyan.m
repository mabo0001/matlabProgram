clc;clear;

if matlabpool('size')<=0
   
    matlabpool('open','local',4);
    
else
    
    disp('Already initialized');
    
end

V = 6;

if V == 1
    
    lx = 1; ly = 0; lz = 0;
    
    kx = 1; ky = 0; kz = 0;
    
elseif V == 2
    
    lx = 0; ly = 1; lz = 0;
    
    kx = 1; ky = 0; kz = 0;
    
elseif V == 3
    
    lx = 1; ly = 0; lz = 0;
    
    kx = 0; ky = 0; kz = 1;
    
elseif V == 4
    
    lx = 0; ly = 1; lz = 0;
    
    kx = 0; ky = 1; kz = 0;
    
    
elseif V == 5
    
    lx = 0; ly = 0; lz = 1;
    
    kx = 0; ky = 1; kz = 0;
    
elseif V == 6
    
    lx = 0; ly = 0; lz = 1;
    
    kx = 0; ky = 0; kz = 1;
    
end

l = [lx ly lz];


tic;

[nodedata,eledata,facedata,neighdata,p] = Readdata('rec7.1');


% Vyz shi,jieguo xiang cha yige fuhao;

i=0;

N=size(eledata,1);

for x=0:50:1000
    
    i=i+1
    
    j=0;
    
    for y = 0:50:1000
        
        j=j+1;
        
        nodedata1(:,1) = nodedata(:,1)-x;
        
        nodedata1(:,2) = nodedata(:,2)-y;
        
        nodedata1(:,3) = -nodedata(:,3);
        
        parfor ii=1:N
            
              if p(ii)~= 0;
                
                  [gravity(ii)]=ele_gravity(ii,p(ii),eledata,nodedata1,l,kx,ky,kz);
                
              end
        end
        
        Vab(i,j)=sum(gravity);
        
        
        % [nodedata,eledata,facedata,neighdata,p] = Readdata('rec.1');
        
    end
end
figure;contourf(Vab)

matlabpool close

toc;
a=zeros(441,1);
l=0;
% [Vxy]=rectangular(0:50:1000,0:50:1000,500,500,200,200,300,700,0.5)+rectangular(0:50:1000,0:50:1000,500,500,500,500,0.1,1000,0.5);
% [Vxy]=rectangular(0:50:1000,0:50:1000,500,500,500,500,10,1000,1);
[Vxy]=rectangular(0:50:1000,0:50:1000,500,500,200,200,150,350,1);
for i = 1:21
    for j= 1:21
        l=l+1;
        a(l) = Vab(i,j);
    end
end
figure;plot(a,'o')
hold on
plot(Vxy,'r')
error = (a -Vxy);

