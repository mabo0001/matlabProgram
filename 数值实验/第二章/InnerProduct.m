function  f  = InnerProduct( x,y,w )
%求内积
%   此处显示详细说明
if(size(x,2)~=size(y,2)||size(x,2)~=size(w,2)||size(w,2)~=size(y,2))
    f='x，y,w长度不相等';
end
N=size(x,2);
sum=0;
for i=1:N
    sum=sum+x(i)*y(i)*w(i);
end
f=sum;

end

