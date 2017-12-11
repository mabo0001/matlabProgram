clc;clear;
tic;
[nodedata,eledata,facedata,p] = Readdata('rec.1');

N=size(eledata,1);

Gijj=zeros(441,N);

loop=0;

for x=0:50:1000

    
    for y = 0:50:1000
       
        loop=loop+1
        
        nodedata(:,1) = x-nodedata(:,1);
        
        nodedata(:,2) = y-nodedata(:,2);       
                
for ii=1:N
Gijj(loop,ii)=ele_gravity(ii,6,p,eledata,nodedata);
end


[nodedata,eledata,facedata,p] = Readdata('rec.1');


    end
end
toc;