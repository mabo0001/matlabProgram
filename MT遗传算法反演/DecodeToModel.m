function [ lambda ] = DecodeToModel( pop5,length )
%解码成模型
%   此处显示详细说明
    temp1=100+decodechrom(pop5,1,length(1))*100/(2^length(1)-1);
    lambda(:,1)=temp1;
    for i=2:size(length,2)
        temp2=100+decodechrom(pop5,1+(i-1)*length(i-1),length(i))*100/(2^length(i)-1);
        lambda(:,i)=temp2;
    end

end

