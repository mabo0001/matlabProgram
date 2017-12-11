function [XYZ] = Rotate(num_ele,eledata,nodedata,SO)
%%    XYZ(1,:) = [X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3];

XYZ = zeros(4,9);

a = [1 2 3; 2 3 4; 3 4 1; 4 1 2]; % si ge mian
%% 1-2-3-4 mian123

for i = 1:4

H = nodedata(eledata(num_ele,a(i,1)),:);

x1 = H(1); y1 = H(2); z1 = H(3);

I = nodedata(eledata(num_ele,a(i,2)),:);

x2 = I(1); y2 = I(2); z2 = I(3);

J = nodedata(eledata(num_ele,a(i,3)),:);

x3 = J(1); y3 = J(2); z3 = J(3);

cos_phy = SO(i,3);

if cos_phy>1
    
    cos_phy = 1;
    
elseif cos_phy<-1
    
    cos_phy = -1;
    
end

if abs(cos_phy - 1) < 10^(-8)
    
    X1 = x1; Y1 = y1; Z1 = z1;
    
    X2 = x2; Y2 = y2; Z2 = z2;
    
    X3 = x3; Y3 = y3; Z3 = z3;
    
elseif abs(cos_phy - (-1))<10^(-8)
    
    X1 = -x1; Y1 = y1; Z1 = -z1;
    
    X2 = -x2; Y2 = y2; Z2 = -z2;
    
    X3 = -x3; Y3 = y3; Z3 = -z3;
    
else
    
    sin_phy = sqrt(1-cos_phy^2);
    
    sin_theda = SO(i,2)/sin_phy;
    
    cos_theda = SO(i,1)/sin_phy;
    
    A = [cos_phy 0 -sin_phy;0 1 0; sin_phy 0 cos_phy];
    
    B = [cos_theda sin_theda 0;-sin_theda cos_theda 0;0 0 1];
    
    K = A*B*[x1;y1;z1];
    
    X1 = K(1); Y1 = K(2); Z1 = K(3);
    
    K = A*B*[x2;y2;z2];
    
    X2 = K(1); Y2 = K(2); Z2 = K(3);
    
    K = A*B*[x3;y3;z3];
    
    X3 = K(1); Y3 = K(2); Z3 = K(3);
    
    
end
XYZ(i,:) = [X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3];

end
%  for i = 1:4
%     
%     if abs(XYZ(i,3)-XYZ(i,6))>10^(-6)|abs(XYZ(i,3)-XYZ(i,9))>10^(-6)|abs(XYZ(i,6)-XYZ(i,9))>10^(-6)
%         
%         disp('mistake');
%         
%               
%     end
%     
% end
