function [ parameter10 ] = Decode( Population ,StartPoint,Length)
%����
%   �˴���ʾ��ϸ˵��

parameter2=Population(:,StartPoint:StartPoint+Length-1);
temp=zeros(size(Population,1),Length);
%ת����ʮ����
for i=1:Length
    temp(:,i)=temp(:,i)+parameter2(:,i).*2.^(Length-i);
    
end
parameter10=sum(temp,2);
end

