function [ lambda ] = DecodeToModel( Population,length,a,b )
%�����ģ��
%   �˴���ʾ��ϸ˵��
    temp1=a(1)+Decode(Population,1,length(1))*(b(1)-a(1))/(2^length(1)-1);
%     newlength=[1,length];���������
newlength=1;
for i=1:size(length,2)
    newlength(i+1)=newlength(i)+length(i);
end

    lambda(:,1)=temp1;
    for i=2:size(length,2)
        temp2=a(i)+Decode(Population,newlength(i),length(i))*(b(i)-a(i))/(2^length(i)-1);
        lambda(:,i)=temp2;
    end

end

