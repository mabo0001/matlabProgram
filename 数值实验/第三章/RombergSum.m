function [ sum ] = RombergSum( a,b,i )
%Romberg������е��Ǹ��ۼӺ�
%   �˴���ʾ��ϸ˵��
sum=0;
for j=1:i
  sum=sum+F_target(a+(2*j-1)*(b-a)/(2^i));
end
sum=sum*((b-a)/(2^i));

end

