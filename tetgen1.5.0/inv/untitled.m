eledata1 =[];
loop = 0;
bb = 0;
p1 =[];
for i = 1:8987
    
    bb=0;
    
    for j = 1:4
        
        aa = (nodedata(eledata(i,j),1)>500 ||   nodedata(eledata(i,j),2)>1000   || nodedata(eledata(i,j),3)>1000);
        
        bb = bb+aa;
        
        if   bb == 4
            loop =loop+1;
            
            eledata1(loop,:) =eledata(i,:);
            p1(loop)=p(i);
            
        end
    end
    
    
    
end