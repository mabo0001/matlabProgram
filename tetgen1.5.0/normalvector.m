function [vec12,vec23,vec31] = normalvector(xx,yy)

%% bian de fang xiang liang


close all;
% xx = rand(3,1);yy = rand(3,1);
x1 = xx(1);y1 = yy(1);
x2 = xx(2);y2 = yy(2);
x3 = xx(3);y3 = yy(3);
% 
% patch(xx,yy,'w');
% axis off;

% a12 = [x2 - x1,y2 - y1];
% a23 = [x3 - x2,y3 - y2];
% a31 = [x1 - x3,y1 - y3];


% linear equation

if (x1 ~= x2) && (y1 ~= y2)
    
    k1 = (y2 - y1)/(x2 - x1);
    
    b1 = y1 - k1*x1;
    
    k2 = -1/k1;

    b2 = y3 - x3*k2;
    
    x = -(b1 - b2)/(k1 - k2);
    
    y = (b1*k2 - b2*k1)/(k2 - k1);
    
elseif (x1 == x2)&&(y1 ~= y2)
    
    x = x2;
    y = y3;
    
elseif (x1 ~= x2)&&(y1 == y2)
    
    x = x3;
    y = y1;          
    
end

vec12 = [x - x3,y - y3];

vec12 = vec12/norm(vec12);

% 
% hold on;
% quiver(x,y,vec12(1),vec12(2));



if (x2 ~= x3) && (y2 ~= y3)
    
    k = (y3 - y2)/(x3 - x2);
    
    b1 = y2 - k*x2;

    b2 = y1 + x1/k;
    
    x = -k*(b1 - b2)/(k*k + 1);
    
    y = (k*k*b2 + b1)/(k*k + 1);
    
elseif (x2 == x3)&&(y2 ~= y3)
    
    x = x2;
    y = y1;
    
elseif (x2 ~= x3)&&(y2 == y3)
    
    x = x1;
    y = y2;          
    
end
vec23 = [x - x1,y - y1];

vec23 = vec23/norm(vec23);


% hold on;
% quiver(x,y,vec23(1),vec23(2));

if (x1 ~= x3) && (y1 ~= y3)
    
    k = (y1 - y3)/(x1 - x3);
    
    b1 = y1 - k*x1;
    
    % normal vector

    

    b2 = y2 + x2/k;
    
    x = -k*(b1 - b2)/(k*k + 1);
    
    y = (k*k*b2 + b1)/(k*k + 1);
    
elseif (x1 == x3)&&(y1 ~= y3)
    
    x = x1;
    y = y2;
    
elseif (x1 ~= x3)&&(y1 == y3)
    
    x = x2;
    y = y3;          
    
end
vec31 = [x - x2,y - y2];

vec31 = vec31/norm(vec31);

end















            