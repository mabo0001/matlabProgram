function [point] = zhongxin(nodedata,eledata);

N = size(eledata,1);

point = zeros(N,3);

for i = 1:N
    
  point(i,1) = (nodedata(eledata(i,1),1)+nodedata(eledata(i,2),1)+nodedata(eledata(i,3),1)...
               +nodedata(eledata(i,4),1))/4;
    
  point(i,2) = (nodedata(eledata(i,1),2)+nodedata(eledata(i,2),2)+nodedata(eledata(i,3),2)...
               +nodedata(eledata(i,4),2))/4;  
        
  point(i,3) = (nodedata(eledata(i,1),3)+nodedata(eledata(i,2),3)+nodedata(eledata(i,3),3)...
               +nodedata(eledata(i,4),3))/4;
        
end