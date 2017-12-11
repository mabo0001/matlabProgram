function [Vzz]=rectangular(x,y,x0,y0,a,b,h1,h2,condensity);
%ֱ������������ͶӰ���(x0,y0,0),�ϵ�����h1���µ�����h2,x�򳤶�2a,y�򳤶�2b��
Nx=length(x);
Ny=length(y);
Gra=6.67E-11;
X(1)=x0-a;
X(2)=x0+a;
Y(1)=y0-b;
Y(2)=y0+b;
Z(1)=h1;
Z(2)=h2;
%[x,y]=meshgrid([20:40:580]);
p=Nx;
q=Ny;
Gxx=zeros(p,q);Gzz=zeros(p,q);Gxz=zeros(p,q);Gyz=zeros(p,q);Gxy=zeros(p,q);Gyy=zeros(p,q);Vzz=zeros(p*q,1);Vxx=zeros(p*q,1);Vxy=zeros(p*q,1);Vxz=zeros(p*q,1);Vyz=zeros(p*q,1);Vyz=zeros(p*q,1);
%Vyy=zeros(p,q);
%Gz=zeros(p,q);

%
for n=1:Ny
    for m=1:Nx
for k=1:2
    for j=1:2
        for i=1:2
            R=sqrt((X(i)-x(m)).^2+(Y(j)-y(n)).^2+Z(k).^2);
%           Gz(m,n)=Gz(m,n)+(-Gra*condensity*(-1)^(i+j+k)*((X(i)-x(m)).*log((Y(j)-y(n))+R)+(Y(j)-y(n)).*log((X(i)-x(m))+R)+2*Z(k).*atan(((X(i)-x(m))+(Y(j)-y(n))+R)./Z(k))));
             Gxx(m,n)=Gxx(m,n)+Gra*condensity*(-1)^(i+j+k)*(atan(((X(i)-x(m))*R)/((Y(j)-y(n))*Z(k)+eps)));
             Gyy(m,n)=Gyy(m,n)+Gra*condensity*(-1).^(i+j+k).*atan(((Y(j)-y(n)).*R)./((X(i)-x(m)).*Z(k)+eps));
            Gzz(m,n)=Gzz(m,n)+Gra*condensity*(-1).^(i+j+k).*atan((Z(k).*R)./((X(i)-x(m)).*(Y(j)-y(n))+eps));
         
% Gzz(m,n)=Gzz(m,n)+Gra*condensity*(-1).^(i+j+k).*atan(((X(i)-x(m)).*(Y(j)-y(n)))./(Z(k).*R+eps));
             Gxz(m,n)=Gxz(m,n)+Gra*condensity*(-1).^(i+j+k).*log((Y(j)-y(n))+R+eps);         
%            Vzx(m,n)=Vxz(m,n);
            Gyz(m,n)=Gyz(m,n)+Gra*condensity*(-1).^(i+j+k).*log((X(i)-x(m))+R+eps);
%            Vzy(m,n)=Vyz(m,n);
            Gxy(m,n)=Gxy(m,n)+Gra*condensity*(-1).^(i+j+k).*log(Z(k)+R+eps);
       %     Vyx(m,n)=Vxy(m,n);
        end
    end
end
    end
end
% x0=500;
% y0=700;
% a=100;
% b=100;
% h1=100;
% h2=300;
% X(1)=x0-a;
% X(2)=x0+a;
% Y(1)=y0-b;
% Y(2)=y0+b;
% Z(1)=h1;
% Z(2)=h2;
% %[x,y]=meshgrid([20:40:580]);
% x=(25:1000/Nx:975);
% y=(25:1000/Ny:975);
% p=Nx;
% q=Ny;
% %Gz=zeros(p,q);
% 
% %Vyy=zeros(p,q);
% %
% for n=1:Ny
%     for m=1:Nx
% for k=1:2
%     for j=1:2
%         for i=1:2
%             R=sqrt((X(i)-x(m)).^2+(Y(j)-y(n)).^2+Z(k).^2);
% %           Gz(m,n)=Gz(m,n)+(-Gra*condensity*(-1)^(i+j+k)*((X(i)-x(m)).*log((Y(j)-y(n))+R)+(Y(j)-y(n)).*log((X(i)-x(m))+R)+2*Z(k).*atan(((X(i)-x(m))+(Y(j)-y(n))+R)./Z(k))));
% %             Gxx(m,n)=Gxx(m,n)+Gra*condensity*(-1)^(i+j+k)*(atan(((X(i)-x(m))*R)/((Y(j)-y(n))*Z(k)+eps)));
% %             Vyy(m,n)=Vyy(m,n)+Gra*condensity*(-1).^(i+j+k).*atan(((Y(j)-y(n)).*R)./((X(i)-x(m)).*Z(k)+eps));
%             Gzz(m,n)=Gzz(m,n)+Gra*condensity*(-1).^(i+j+k).*atan(((X(i)-x(m)).*(Y(j)-y(n)))./(Z(k).*R+eps));
% %             Gxz(m,n)=Gxz(m,n)+Gra*condensity*(-1).^(i+j+k).*log((Y(j)-y(n))+R);
% %            Vzx(m,n)=Vxz(m,n);
% %            Gyz(m,n)=Gyz(m,n)+Gra*condensity*(-1).^(i+j+k).*log((X(i)-x(m))+R);
% %            Vzy(m,n)=Vyz(m,n);
% %            Gxy(m,n)=Gxy(m,n)+Gra*condensity*(-1).^(i+j+k).*log(Z(k)+R);
%        %     Vyx(m,n)=Vxy(m,n);
%         end
%     end
% end
%     end
% end
% figure; contourf(Gyz);
loop=0;
for i=1:Ny
    for j=1:Nx
        loop=loop+1;
        Vzz(loop)=Gzz(i,j);
        Vxx(loop)=Gxx(i,j);
        Vxy(loop)=Gxy(i,j);
        Vxz(loop)=Gxz(i,j);
        Vyy(loop)=Gyy(i,j)';
        Vyz(loop)=Gyz(i,j);
    end
end

