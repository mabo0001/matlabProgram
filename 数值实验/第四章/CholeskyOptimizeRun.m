clear
clc
A=[4,-1,1;-1,4.25,2.75;1,2.75,3.5];
b=[6;-0.5;1.25];
[ L,d,y,x ] = CholeskyOptimize( A,b )
% n=size(A,2);
% L=zeros(n,n);
% d(1,1)=A(1,1);
% for i=1:n
%     L(i,i)=1;
% end
% 
% for j=1:n
%     sum=0;
%     for k=1:j-1
%         sum=sum+L(j,k)*L(j,k)*d(k,k)
%     end
%     d(j,j)=A(j,j)-sum;
%     for i=j+1:n
%         sum=0;
%         for k=1:j-1
%             sum=sum+d(k,k)*L(i,k)*L(j,k);
%         end
%         L(i,j)=(A(i,j)-sum)/d(j,j);
%     end
% end
