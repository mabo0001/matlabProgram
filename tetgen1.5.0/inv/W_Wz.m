function [W_Wz]=W_Wz(nodedata,eledata)

num_ele = size(eledata,1);

% W_Wz = zeros(num_ele,num_ele);

% W_Wz = sparse(W_Wz);

beda=1.8;
Wz = zeros(num_ele,1);
for i = 1:num_ele
            
 t1 =(nodedata(eledata(i,1),3)+nodedata(eledata(i,2),3)+nodedata(eledata(i,3),3)...
     +nodedata(eledata(i,4),3))/4;
    
Wz(i)=(t1)^(-beda/2);
   
end
W_Wz = spdiags(Wz,0,num_ele,num_ele);
