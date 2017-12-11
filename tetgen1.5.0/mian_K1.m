function [Ki] = mian_Ki(SO,XYZ,V,i)

% kx ky kz;lx ly lz 
% xuan ze zheng yan fen liang
% 1--Vxx;2--Vxy;3--Vxz,4--Vyy,5--Vyz;6--Vzz

if V == 1
    
    kx = 1; ky = 0; kz = 0;
       
elseif V == 2
    
    kx = 1; ky = 0; kz = 0;
      
elseif V == 3
    
    kx = 0; ky = 0; kz = 1;
        
elseif V == 4
    
    kx = 0; ky = 1; kz = 0;
         
elseif V == 5
    
    kx = 0; ky = 1; kz = 0;
        
elseif V == 6
    
    kx = 0; ky = 0; kz = 1;
        
end

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

sin_v12 = vec12(1); sin_v23 = vec23(1); sin_v31 = vec31(1);% xiang cha fuhao 

cos_phy = SO(i,3);

if cos_phy>1
    
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

if abs(XYZ(i,3))<10^(-6)
    
    if abs(XY(1,2))<10^(-6)
        
        if abs(XY(1,3))<10^(-6);
            
             L2 = 0;
            
             L1 = (My*cos_v12-Mx*sin_v12)*(-log(-2*XY(1,1)));
            
        elseif abs(XY(1,1))<10^(-6)
            
             L2 = (My*cos_v12-Mx*sin_v12)*(log(2*XY(1,3)));
            
             L1 = 0;
             
        elseif XY(1,3)<0 
                    
             L2 = (My*cos_v12-Mx*sin_v12)*(-log(-2*XY(1,3)));
        
             L1 = (My*cos_v12-Mx*sin_v12)*(-log(-2*XY(1,1)));
        
        elseif XY(1,3)>0 & XY(1,1)<0 % XY(1,1)--(-eps)--(+eps)--XY(1,3)
            
        L2 = 0;%(My*cos_v12-Mx*sin_v12)*(-log(-2*(-eps)));
        
        L1 = (My*cos_v12-Mx*sin_v12)*(-log(-2*XY(1,1)));   
        
        L2 = L2+(My*cos_v12-Mx*sin_v12)*log(2*XY(1,3));
        
        L1 = L1+0;%(My*cos_v12-Mx*sin_v12)*log(2*eps);
        
        else
        
        L2 = (My*cos_v12-Mx*sin_v12)*log(XY(1,3)+sqrt(XY(1,3)^2+XY(1,2)^2+XYZ(i,3)^2+eps));
        
        L1 = (My*cos_v12-Mx*sin_v12)*log(XY(1,1)+sqrt(XY(1,1)^2+XY(1,2)^2+XYZ(i,3)^2)+eps);
        
        end
        
    else
        
        L2 = (My*cos_v12-Mx*sin_v12)*log(XY(1,3)+sqrt(XY(1,3)^2+XY(1,2)^2+XYZ(i,3)^2+eps));
        
        L1 = (My*cos_v12-Mx*sin_v12)*log(XY(1,1)+sqrt(XY(1,1)^2+XY(1,2)^2+XYZ(i,3)^2)+eps);
    end
    
elseif  abs(cos_v12) <10^(-6)
        
        L2 = (My*cos_v12-Mx*sin_v12)*log(XY(1,3)+sqrt(XY(1,3)^2+XY(1,2)^2+XYZ(i,3)^2+eps));
        
        L1 = (My*cos_v12-Mx*sin_v12)*log(XY(1,1)+sqrt(XY(1,1)^2+XY(1,2)^2+XYZ(i,3)^2)+eps);
    
else        
    
L2 = (My*cos_v12-Mx*sin_v12)*log(XY(1,3)+sqrt(XY(1,3)^2+XY(1,2)^2+XYZ(i,3)^2))+...
    Mz*atan((-XY(1,2)*XY(1,3)+(XYZ(i,3)^2+XY(1,2)^2)*sin_v12/cos_v12)/(XYZ(i,3)*sqrt(XY(1,3)^2+XY(1,2)^2+XYZ(i,3)^2)));

L1 = (My*cos_v12-Mx*sin_v12)*log(XY(1,1)+sqrt(XY(1,1)^2+XY(1,2)^2+XYZ(i,3)^2))+...
    Mz*atan((-XY(1,2)*XY(1,1)+(XYZ(i,3)^2+XY(1,2)^2)*sin_v12/cos_v12)/(XYZ(i,3)*sqrt(XY(1,1)^2+XY(1,2)^2+XYZ(i,3)^2)));

end

L = L2-L1;

Ki = Ki+L;

%% 2-3 bian

if abs(XYZ(i,3))<10^(-6)
    
    if abs(XY(2,2))<10^(-6)
        
        if abs(XY(2,3))<10^(-6)
        
            L2 = 0;
            
            L1 = (My*cos_v23-Mx*sin_v23)*(-log(-2*XY(2,1)));
            
        elseif abs(XY(2,1))<10^(-6)
            
            L2 = L2+(My*cos_v23-Mx*sin_v23)*log(2*XY(2,3));
            
            L1 = 0;
            
        elseif XY(2,3)<0 & XY(2,1)<0
        
        L2 = (My*cos_v23-Mx*sin_v23)*(-log(-2*XY(2,3)));
        
        L1 = (My*cos_v23-Mx*sin_v23)*(-log(-2*XY(2,1)));
        
        elseif XY(2,3)>0 & XY(2,1)<0 % XY(1,1)--(-eps)--(+eps)--XY(1,3)
            
        L2 = 0;%(My*cos_v23-Mx*sin_v23)*(-log(-2*(-eps)));
        
        L1 = (My*cos_v23-Mx*sin_v23)*(-log(-2*XY(2,1)+eps));
        
        L2 = L2+(My*cos_v23-Mx*sin_v23)*log(2*XY(2,3));
        
        L1 = L1;%+(My*cos_v23-Mx*sin_v23)*log(2*eps);            
       else
        
        L2 = (My*cos_v23-Mx*sin_v23)*log(XY(2,3)+eps+sqrt(XY(2,3)^2+XY(2,2)^2+XYZ(i,3)^2));
        
        L1 = (My*cos_v23-Mx*sin_v23)*log(XY(2,1)+eps+sqrt(XY(2,1)^2+XY(2,2)^2+XYZ(i,3)^2));
        
        end
       
        else
        
        L2 = (My*cos_v23-Mx*sin_v23)*log(XY(2,3)+eps+sqrt(XY(2,3)^2+XY(2,2)^2+XYZ(i,3)^2));
        
        L1 = (My*cos_v23-Mx*sin_v23)*log(XY(2,1)+eps+sqrt(XY(2,1)^2+XY(2,2)^2+XYZ(i,3)^2));
        
    end
    
elseif  abs(cos_v23) <10^(-6)
          
        L2 = (My*cos_v23-Mx*sin_v23)*log(XY(2,3)+eps+sqrt(XY(2,3)^2+XY(2,2)^2+XYZ(i,3)^2));
        
        L1 = (My*cos_v23-Mx*sin_v23)*log(XY(2,1)+eps+sqrt(XY(2,1)^2+XY(2,2)^2+XYZ(i,3)^2));  
    
else    

L2 = (My*cos_v23-Mx*sin_v23)*log(XY(2,3)+sqrt(XY(2,3)^2+XY(2,2)^2+XYZ(i,3)^2))+...
    Mz*atan((-XY(2,2)*XY(2,3)+(XYZ(i,3)^2+XY(2,2)^2)*sin_v23/cos_v23)/(XYZ(i,3)*sqrt(XY(2,2)^2+XY(2,3)^2+XYZ(i,3)^2)));

L1 = (My*cos_v23-Mx*sin_v23)*log(XY(2,1)+sqrt(XY(2,2)^2+XY(2,1)^2+XYZ(i,3)^2))+...
    Mz*atan((-XY(2,2)*XY(2,1)+(XYZ(i,3)^2+XY(2,2)^2)*sin_v23/cos_v23)/(XYZ(i,3)*sqrt(XY(2,2)^2+XY(2,1)^2+XYZ(i,3)^2)));

end

L = L2-L1;

Ki = Ki+L;

%% 3-1bian

if abs(XYZ(i,3))<10^(-6)
    
    if abs(XY(3,2))<10^(-6)
        
        if abs(XY(3,3))<10^(-6)
        
            L2 = 0;
            
            L1 = (My*cos_v31-Mx*sin_v31)*(-log(-2*XY(3,1)));
            
        elseif abs(XY(3,1))<10^(-6)
            
            L2 = L2+(My*cos_v31-Mx*sin_v31)*log(2*XY(3,3));
            
            L1 = 0;
            
        elseif XY(3,3)<0 & XY(3,1)<0
        
        L2 = (My*cos_v31-Mx*sin_v31)*(-log(-2*XY(3,3)));
        
        L1 = (My*cos_v31-Mx*sin_v31)*(-log(-2*XY(3,1)));
        
        elseif XY(3,3)>0 & XY(3,1)<0 % XY(1,1)--(-eps)--(+eps)--XY(1,3)
            
        L2 = 0;% (My*cos_v31-Mx*sin_v31)*(-log(-2*(-eps)));
        
        L1 = (My*cos_v31-Mx*sin_v31)*(-log(-2*XY(3,1)+eps));
        
        L2 = L2+(My*cos_v31-Mx*sin_v31)*log(2*XY(3,3));
        
        L1 = L1;%+(My*cos_v31-Mx*sin_v31)*log(2*eps);            
       else
        
        L2 = (My*cos_v31-Mx*sin_v31)*log(XY(3,3)+eps+sqrt(XY(3,3)^2+XY(3,2)^2+XYZ(i,3)^2));
        
        L1 = (My*cos_v23-Mx*sin_v31)*log(XY(3,1)+eps+sqrt(XY(3,1)^2+XY(3,2)^2+XYZ(i,3)^2));
        
        end
       
        else
        
        L2 = (My*cos_v31-Mx*sin_v31)*log(XY(3,3)+eps+sqrt(XY(3,3)^2+XY(3,2)^2+XYZ(i,3)^2));
        
        L1 = (My*cos_v31-Mx*sin_v31)*log(XY(3,1)+eps+sqrt(XY(3,1)^2+XY(3,2)^2+XYZ(i,3)^2));
        
    end
    
      elseif  abs(cos_v31) <10^(-6)
          
        L2 = (My*cos_v31-Mx*sin_v31)*log(XY(3,3)+eps+sqrt(XY(3,3)^2+XY(3,2)^2+XYZ(i,3)^2));
        
        L1 = (My*cos_v31-Mx*sin_v31)*log(XY(3,1)+eps+sqrt(XY(3,1)^2+XY(3,2)^2+XYZ(i,3)^2));  
    
else    

L2 = (My*cos_v31-Mx*sin_v31)*log(XY(3,3)+sqrt(XY(3,3)^2+XY(3,2)^2+XYZ(i,3)^2))+...
    Mz*atan((-XY(3,2)*XY(3,3)+(XYZ(i,3)^2+XY(3,2)^2)*sin_v31/cos_v31)/(XYZ(i,3)*sqrt(XY(3,2)^2+XY(3,3)^2+XYZ(i,3)^2)));

L1 = (My*cos_v31-Mx*sin_v31)*log(XY(3,1)+sqrt(XY(3,2)^2+XY(3,1)^2+XYZ(i,3)^2))+...
    Mz*atan((-XY(3,2)*XY(3,1)+(XYZ(i,3)^2+XY(3,2)^2)*sin_v31/cos_v31)/(XYZ(i,3)*sqrt(XY(3,2)^2+XY(3,1)^2+XYZ(i,3)^2)));

end

L = L2-L1;

Ki = Ki+L;
