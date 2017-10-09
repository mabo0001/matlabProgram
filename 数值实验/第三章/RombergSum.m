function [ sum ] = RombergSum( a,b,i )
%Romberg求积分中的那个累加和
%   此处显示详细说明
sum=0;
for j=1:i
  sum=sum+F_target(a+(2*j-1)*(b-a)/(2^i));
end
sum=sum*((b-a)/(2^i));

end

