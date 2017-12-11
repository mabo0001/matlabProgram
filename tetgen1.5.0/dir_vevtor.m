function  [SO] = dir_vevtor(num_ele,eledata,nodedata)
%% num_eleΪ��Ԫ���
%% simianti de fang xiang liang

SO = zeros(4,3);

a = [ 1 2 3 4;2 3 4 1;3 4 1 2; 4 1 2 3];% si ge ding dian ;

%% 1-2-3-4

for i = 1:4
    
    H = nodedata(eledata(num_ele,a(i,1)),:);
    
    x1 = H(1); y1 = H(2); z1 = H(3);
    
    I = nodedata(eledata(num_ele,a(i,2)),:);
    
    x2 = I(1); y2 = I(2); z2 = I(3);
    
    J = nodedata(eledata(num_ele,a(i,3)),:);
    
    x3 = J(1); y3 = J(2); z3 = J(3);
    
    K = nodedata(eledata(num_ele,a(i,4)),:);
    
    x4 = K(1); y4 = K(2); z4 = K(3);
    
    
    AB = [x2-x1,y2-y1,z2-z1];
    
    AC = [x3-x1,y3-y1,z3-z1];
    
    S1 =cross(AB,AC);
    
    SA = [x1-x4,y1-y4,z1-z4];
    
    if SA*S1'<0
        
        S1 = -S1;
        
    end
    
    SO(i,:) = S1/norm(S1+eps);
end


