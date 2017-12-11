function out=Sim(i,j) %i,j是两子矩阵存储的文件名

load('Gij11.mat');





if i == 9
    
    D1=Gij(i*45+1:end,:);
    
else
    
    D1=Gij(i*45+1:i*45+45,:);
    
end

if j == 9
    
    D2=Gij(j*45+1:end,:);
    
else
    
    D2=Gij(j*45+1:j*45+45,:);
    
end


AF1=full(D1);

AF2=full(D2);

AFF1=AF1./repmat(sqrt(sum(AF1.^2,2)),1,size(AF1,2));

AFF2=AF2./repmat(sqrt(sum(AF2.^2,2)),1,size(AF2,2));

out=AFF1'*AFF2;