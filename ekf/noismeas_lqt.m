function [sumr]=noismeas_lqt(r0)
% Calculate the apparent resistivity dataset of sphere with central gradient array,with noise added 
% Input: x: radius of sphere
% Output:sumr:sum of weighted apparent resistivity of each measure point

% ％使用中心梯度阵列计算球体的视电阻率数据集，并添加噪声
% ％输入：x：球体半径
% ％输出：sumr：每个测量点的加权视电阻率之和


theta=40*pi/180;
z=4;
x0=0;
rho_1=100;
rho_2=500;
DU0=10;
q=1;
nois=0.1;

K_LQT=-(2*rho_1*r0*r0*DU0)/(2*rho_2+rho_1);

k=1;
sumr=0.;

for x=-60:60
    V(k)=K_LQT.*((x-x0).*cos(theta)+z.*sin(theta))./(((x-x0).^2+z.^2).^q);
    V(k)=V(k)*(1.0+nois*(randn-0.5));
    cre(k)=1./power(1.1,abs(x));
    sumr=sumr+V(k)*cre(k);
end
    sumr=sumr/1000.;    % adjust amplitude/range 调整幅度/范围
    

end