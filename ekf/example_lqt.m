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

h=@(x)[measure_lqt(x(1))];                          % measurement equation 测量方程

aa0=1.;
s=[aa0];
x=s+q*randn;         % initial state % initial state with noise 初始化状态（加噪声）
P = eye(n);          % initial state covraiance 协方差初始状态
N = 30;                % total dynamic steps 动态迭代总数
xV = zeros(1,N);     % estmate % allocate memory  估计％分配内存
sV = zeros(1,N);     % actual 实际
zV = zeros(1,N);

ssT = zeros(1,N);    % The true radius of sphere (true state) 球体的真实半径（真实状态）
nois=0.1; % 模型噪声
dr=0.02; % 板状体半长递增值
for k=1:N
    aa1=(aa0+k*dr)*(1+nois*(randn-0.5));
    
    ssT(:,k)=aa1;
    zz=noismeas_lqt(aa1);
    z=zz+r*randn;
    sV(:,k)= s;          % save actual state 保存实际状态
    zV(:,k) = z;         % save measurment 保存测量状态
    [x, P] = ekf(f,x,P,h,z,Q,R); % ukf
    xV(:,k) = x;                 % save estimate 保存估计状态
    s = f(s) + q*randn;     % update process 更新处理
end

figure(1);
plot(1:N, ssT(1,:), 1:N, xV(1,:));
legend('球体的真实半径（真实状态）','球体Kalman估计值（状态）')
grid on;

figure(2);
for i=1:size(ssT,2)
    % 修改模型的话这里要修改，而且measure和noise都要修改，且保持一致
    if(mod(i,5)==0)
        subplot(3,2,i/5)
        
        x1=-60:60;
        theta=40*pi/180;
        z=4;
        x0=0;
        rho_1=100;
        rho_2=500;
        DU0=10;
        q=1;
        V_ZY=NEF_forward_leiqiuti( x1,theta,q,z,x0,xV(i),rho_1,rho_2,DU0 );
        V_FY=NEF_forward_leiqiuti( x1,theta,q,z,x0,ssT(i),rho_1,rho_2,DU0 );
        
        nihecha= abs(sum((V_ZY-V_FY)./V_ZY)/size(V_ZY,2));
        
        plot(x1,V_ZY(1,:),'b--',x1,V_FY(1,:),'r:','LineWidth',2);
        legend('加10%噪音的模拟观测数据','类球体反演模型正演','Location','southwest')
        title(strcat('时间步长为：',num2str(i),'时类球体模型反演效果对比  拟合差：',num2str(nihecha)))
        xlabel('测量位置(m)')
        ylabel('电位差（mV）')
        grid on;
    end

    
end

