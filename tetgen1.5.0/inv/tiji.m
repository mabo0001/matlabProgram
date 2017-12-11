function [V]=tiji(eledata,nodedata);

N = size(eledata,1);

V = sparse(N,N);

A = zeros(1,3);

B = A; C = A; D = A;

for i = 1:N
    
    A(:) = nodedata(eledata(i,1),:);
    
    B(:) = nodedata(eledata(i,2),:);
    
    C(:) = nodedata(eledata(i,3),:);
    
    D(:) = nodedata(eledata(i,4),:);
    
    AB = B-A;
    
    AC = C-A;
    
    AD = D-A;
    
    V(i,i) =abs(1/6*cross(AB,AC)*AD');
    
end
    