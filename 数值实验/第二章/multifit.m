function [ a ] = multifit( x,y,m,w )
%����ʽ���
%   x,y,Ϊ������mΪ����ʽ������wΪ�ڻ�Ȩ��
if(length(x)~=length(y)||length(x)~=length(w)||length(w)~=length(y))
    disp('ά�Ȳ�ƥ��');
end

F=zeros(m+1);
P=zeros(1,m+1)';
for i=1:m+1
    for j=1:m+1
        F(i,j)=InnerProduct( x.^(i-1),x.^(j-1),w );
    end
end

for i=1:m+1
    P(i)=InnerProduct( x.^(i-1),y,w );
end
a=pinv(F)*P;

end

