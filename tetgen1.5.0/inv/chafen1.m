function [W,w] = chafen1(neighdata,V,point);

% N = size(point, 1);
% 
% detax = zeros(N,1);
% 
% detay = detax;
% 
% detaz = detax;
% 
% r = detax;
% 
% Wx = zeros(N,N);
% 
% Wx = sparse(Wx);
% 
% Wy = Wx;
% 
% Wz = Wx;
% 
% for i = 1:N
%     
%     if i == 1 
%         
%         detax(1) = point(1,1)-point(N,1);
%         
%         detay(1) = point(1,2)-point(N,2);
%         
%         detaz(1) = point(1,3)-point(N,3);
%                
%     else
%         
%         
%         detax(i) = point(i,1)-point(i-1,1);
%         
%         detay(i) = point(i,2)-point(i-1,2);
%         
%         detaz(i) = point(i,3)-point(i-1,3);
%                 
%     end
%     
%     r(i) = sqrt(detax(i)^2+detay(i)^2+detaz(i)^2);
%           
%     if i == 1
%         
%         Wx(1,1) = -detax(1)/r(1)^2;  Wx(1,N) = detax(1)/r(1)^2;
%         
%         Wy(1,1) = -detay(1)/r(1)^2;  Wy(1,N) = detay(1)/r(1)^2;
%         
%         Wz(1,1) = -detaz(1)/r(1)^2;  Wz(1,N) = detaz(1)/r(1)^2;
%         
%     else
%         
%         Wx(i,i-1) = detax(i)/r(i)^2;  Wx(i,i) = -detax(i)/r(i)^2;
%         
%         Wy(i,i-1) = detay(i)/r(i)^2;  Wy(i,i) = -detay(i)/r(i)^2;
%         
%         Wz(i,i-1) = detaz(i)/r(i)^2;  Wz(i,i) = -detaz(i)/r(i)^2;
%                
%     end
%     
% end
N = size(neighdata, 1);


W = sparse(4*N,N);

k = 1;

r = 0;

% S = sparse(i,j,s,m,n)
for i = 1:N
    
    for j = 1:4
    
    if neighdata(i,j) >-1;
        
        r = sqrt((point(i,1)-point(neighdata(i,j),1))^2+(point(i,2)-point(neighdata(i,j),2))^2+(point(i,3)-point(neighdata(i,j),3))^2);
                      
        a = sqrt((V(i,i)+V(neighdata(i,j),neighdata(i,j)))/2)/r;
        
        W(k,neighdata(i,j)) = 1*a;
        
        W(k,i) = -1*a;
        
        k = k+1;
        
    end
    
    end
    
end    
w=W;
 W = W'*W;
        
%         i j k 
      
  
