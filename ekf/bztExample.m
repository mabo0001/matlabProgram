clear;
clc;
close all;

n=1;
k=1;
q=0.2;        % std of process 处理过程的标准差
r=0.3;        % std of measurement 监测过程的标准差
Q=q^2*eye(n); % covariance of process 处理过程的协方差
R=r^2*eye(n); % covariance of measurement 测量过程的协方差

f=@(x)[x(1)+k/51.];      % nonlinear state equations 非线性状态方程

h=@(x)[measure_bzt(x(1))];                          % measurement equation 测量方程

aa0=1.; % 板状体半长初始值
s=[aa0];
x=s+q*randn;         % initial state % initial state with noise 初始化状态（加噪声）
P = eye(n);          % initial state covraiance 协方差初始状态
N = 30;                % total dynamic steps 动态迭代总数
xV = zeros(1,N);     % estmate % allocate memory  估计％分配内存
sV = zeros(1,N);     % actual 实际
zV = zeros(1,N);

ssT = zeros(1,N);    % The true radius of sphere (true state) 球体的真实半径（真实状态）
nois=0.3;
dL=0.02; % 板状体半长递增值
for k=1:N
    aa1=(aa0+k*dL)*(1+nois*(randn-0.5));
    
    ssT(:,k)=aa1;
    zz=noise_bzt(aa1);
    z=zz+r*randn;
    sV(:,k)= s;          % save actual state 保存实际状态
    zV(:,k) = z;         % save measurment 保存测量状态
    [x, P] = ekf(f,x,P,h,z,Q,R); % ukf
    xV(:,k) = x;            % save estimate 保存估计状态
    s = f(s) + q*randn;     % update process 更新处理
end

subplot(4,1,1);
plot(1:N, ssT(1,:),'b--', 1:N, xV(1,:),'r-','LineWidth',2);
legend('板状体真实半长','板状体Kalman估计值（状态）')
title('卡尔曼滤波真实值与估计值对比')
xlabel('时间步长')
ylabel('板状体半长（m）')
grid on;

for i=1:size(ssT,2)
    % 修改模型的话这里要修改，而且measure和noise都要修改，且保持一致
    if(mod(i,5)==0)
        subplot(4,2,2+i/5)
        x1=-60:60;
        I=1;
        rho=1000;
        alpha=35*pi/180;
        x0=0;
        z=10;

        V_ZY=NEF_forward_banzhuangti( x1,alpha,z,x0,I,rho,ssT(i));
        V_FY=NEF_forward_banzhuangti( x1,alpha,z,x0,I,rho,xV(i) );

        plot(x1,V_ZY(1,:),'b--',x1,V_FY(1,:),'r:','LineWidth',2);
        legend('加30%噪音的模拟观测数据','板状体反演模型正演','Location','northoutside','Orientation','horizontal')
        title(strcat('时间步长为：',num2str(i),'时板状体模型反演效果对比'))
        xlabel('测量位置(m)')
        ylabel('电位差（mV）')
        grid on;
    end

    
end
