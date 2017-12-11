function [XY] = Rotate_2(xx,yy,vec12,vec23,vec31)
%% XY=[X1,Y1,X2,Y2;X2*,Y2*,X3,Y3;X3*,Y3*,X1*,Y1*]
XY = zeros(3,4);
%% 1-2 bian
cos_v12 = vec12(2); 

sin_v12 = -vec12(1); 

A12 = [cos_v12,sin_v12;-sin_v12,cos_v12];

H = A12*[xx(1);yy(1)];

I = A12*[xx(2);yy(2)];

Y1 = H(2); X1 = H(1);

Y2 = I(2); X2 = I(1);

XY(1,:) = [X1,Y1,X2,Y2];

%% 2-3 bian

cos_v23 = vec23(2); 

sin_v23 = -vec23(1); 

A23 = [cos_v23,sin_v23;-sin_v23,cos_v23];

H = A23*[xx(2);yy(2)];

I = A23*[xx(3);yy(3)];

Y1 = H(2); X1 = H(1);

Y2 = I(2); X2 = I(1);

XY(2,:) = [X1,Y1,X2,Y2];

%% 3-1 bian 
cos_v31 = vec31(2); % kesi

sin_v31 = -vec31(1);

A31 = [cos_v31,sin_v31;-sin_v31,cos_v31];

H = A31*[xx(3);yy(3)];

I = A31*[xx(1);yy(1)];

Y1 = H(2); X1 = H(1);

Y2 = I(2); X2 = I(1);

XY(3,:) = [X1,Y1,X2,Y2];
% for i = 1:3
%     
%     if abs(XY(i,2)-XY(i,4))>10^(-6)
%         
%         disp('mistake2');
%         
%               
%     end
%     
% end
