function [ parameter10 ] = Decode( Population ,StartPoint,Length)
%解码
%   此处显示详细说明

parameter2=Population(:,StartPoint:StartPoint+Length-1);
temp=zeros(size(Population,1),Length);
%转换成十进制
for i=1:Length
    temp(:,i)=temp(:,i)+parameter2(:,i).*2.^(Length-i);
    
end
parameter10=sum(temp,2);
end

