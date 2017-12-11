B=[];

for i=0:9
    
    A=Sim(i,0);
    
    for j=1:9
        
        A=[A,Sim(i,j)];  %hengxiang
        
    end
    
%      dlmwrite(strcat('sim',num2str(i),'.txt'),A,'delimiter',' ');

       B = [B;A];
    
end

A=load('sim0.txt');

for i=1:10
    
    A=[A;dmlread(strcat('sim',num2str(i),'.txt'))];  %zongxiang
        
end
        
        dlmwrite('sim.txt',A,'delimiter',' ');
        