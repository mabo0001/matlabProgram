function [Ki] = mian_Ki(SO,XYZ,i,kx,ky,kz)

% kx ky kz;lx ly lz
% xuan ze zheng yan fen liang
% 1--Vxx;2--Vxy;3--Vxz,4--Vyy,5--Vyz;6--Vzz



%% mian 123
% pan duan shun shi zhen
p1 = [XYZ(i,1),XYZ(i,2)]; p2= [XYZ(i,4),XYZ(i,5)]; p3 = [XYZ(i,7),XYZ(i,8)];

p12= p2-p1; p23 = p3-p2;
% AA wei p12 cha chen p23;

AA = p12(1)*p23(2)-p12(2)*p23(1);

if AA > 0 % ni shi zhen
    
    xx = [XYZ(i,1),XYZ(i,7),XYZ(i,4)];
    
    yy = [XYZ(i,2),XYZ(i,8),XYZ(i,5)];
    
elseif AA < 0 % shun shi zhen
    
    xx = [XYZ(i,1),XYZ(i,4),XYZ(i,7)];
    
    yy = [XYZ(i,2),XYZ(i,5),XYZ(i,8)];
    
end

[vec12,vec23,vec31] = normalvector(xx,yy);

[XY] = Rotate_2(xx,yy,vec12,vec23,vec31);

cos_v12 = vec12(2); cos_v23 = vec23(2); cos_v31 = vec31(2); % kesi

sin_v12 = -vec12(1); sin_v23 = -vec23(1); sin_v31 = -vec31(1);% xiang cha fuhao

cos_v = [cos_v12,cos_v23,cos_v31];

sin_v = [sin_v12,sin_v23,sin_v31];

cos_phy = SO(i,3);

if cos_phy > 1
    
    cos_phy = 1;
    
elseif cos_phy<-1
    
    cos_phy = -1;
    
end

sin_phy = sqrt(1-cos_phy^2);

if abs(sin_phy)<10^(-6)
    
    sin_theda = 0;
    
    cos_theda = 1;
    
else
    
    sin_theda = SO(i,2)/sin_phy;
    
    cos_theda = SO(i,1)/sin_phy;
    
end

Mx = (kx*cos_theda+ky*sin_theda)*cos_phy-kz*sin_phy;

My = -kx*sin_theda+ky*cos_theda;

Mz = (kx*cos_theda+ky*sin_theda)*sin_phy+kz*cos_phy;
%% tao lun cos_v12/23/31/Z =0 de qing kuan
Ki = 0;


%% 1-2 bian

for  j = 1:3
    
    if abs(XYZ(i,3))<10^(-6)
        
        if abs(XY(j,2))<10^(-6)
            
            if abs(XY(j,3))<10^(-6);
                
                L2 = (My*cos_v(j)-Mx*sin_v(j))*(-log(2*10^(-6)));
                
                L1 = (My*cos_v(j)-Mx*sin_v(j))*(-log(-2*XY(j,1)));
                
            elseif abs(XY(j,1))<10^(-6)
                
                L2 = (My*cos_v(j)-Mx*sin_v(j))*(log(2*XY(j,3)));
                
                L1 = (My*cos_v(j)-Mx*sin_v(j))*(log(2*10^(-6)));
                
            elseif XY(j,3)<0
                              
                L2 = (My*cos_v(j)-Mx*sin_v(j))*(-log(-2*XY(j,3)));
                
                L1 = (My*cos_v(j)-Mx*sin_v(j))*(-log(-2*XY(j,1)));
                
            elseif XY(j,3)>0 & XY(j,1)<0 % XY(1,1)--(-eps)--(+eps)--XY(1,3)
                
                L2 = (My*cos_v(j)-Mx*sin_v(j))*(-log(2*10^(-6)));
                
                L1 = (My*cos_v(j)-Mx*sin_v(j))*(-log(-2*XY(j,1)));
                
                L2 = L2+(My*cos_v(j)-Mx*sin_v(j))*log(2*XY(j,3));
                
                L1 = L1+(My*cos_v(j)-Mx*sin_v(j))*log(2*10^(-6));
                
            else
                                              
                L2 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,3)+sqrt(XY(j,3)^2+XY(j,2)^2+XYZ(i,3)^2));
                
                L1 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,1)+sqrt(XY(j,1)^2+XY(j,2)^2+XYZ(i,3)^2));
                
            end
            
        else
                       
            L2 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,3)+sqrt(XY(j,3)^2+XY(j,2)^2+XYZ(i,3)^2));
            
            L1 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,1)+sqrt(XY(j,1)^2+XY(j,2)^2+XYZ(i,3)^2));
        end
        
    elseif  abs(cos_v(j)) <10^(-6)
        
        
        L2 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,3)+sqrt(XY(j,3)^2+XY(j,2)^2+XYZ(i,3)^2));
        
        L1 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,1)+sqrt(XY(j,1)^2+XY(j,2)^2+XYZ(i,3)^2));
        
    else
                
        L2 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,3)+sqrt(XY(j,3)^2+XY(j,2)^2+XYZ(i,3)^2))+...
            Mz*atan((-XY(j,2)*XY(j,3)+(XYZ(i,3)^2+XY(j,2)^2)*(sin_v(j)/cos_v(j)))/(XYZ(i,3)*sqrt(XY(j,3)^2+XY(j,2)^2+XYZ(i,3)^2)));
        
        L1 = (My*cos_v(j)-Mx*sin_v(j))*log(XY(j,1)+sqrt(XY(j,1)^2+XY(j,2)^2+XYZ(i,3)^2))+...
            Mz*atan((-XY(j,2)*XY(j,1)+(XYZ(i,3)^2+XY(j,2)^2)*(sin_v(j)/cos_v(j)))/(XYZ(i,3)*sqrt(XY(j,1)^2+XY(j,2)^2+XYZ(i,3)^2)));
        
    end
   
    L = L2-L1;
    
    Ki = Ki+L;
    
       
end


