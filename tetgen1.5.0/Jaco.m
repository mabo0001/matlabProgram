clc;clear;

if matlabpool('size')<=0
    
    matlabpool('open','local',4);
    
else
    
    disp('Already initialized');
    
end

V = 5;

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

Gij=zeros(441,N);

loop = 0;


for x=0:50:1000
    
    i=i+1
    
    j=0;
    
    for y = 0:50:1000
        
        loop =loop+1;
        
        j=j+1;
        
        nodedata1(:,1) = x-nodedata(:,1);
        
        nodedata1(:,2) = y-nodedata(:,2);
        
        nodedata1(:,3) = nodedata(:,3);
        
       parfor ii=1:N
            
                
                [Gij(loop,ii)]=ele_gravity(ii,1,eledata,nodedata1,l,kx,ky,kz);
                
        end
        
    end
end
% figure;contourf(Vab)

matlabpool close

toc;

