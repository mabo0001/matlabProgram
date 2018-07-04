clear;
clc;
close all;

n=1;
k=1;
q=0.2;        % std of process ������̵ı�׼��
r=0.3;        % std of measurement �����̵ı�׼��
Q=q^2*eye(n); % covariance of process ������̵�Э����
R=r^2*eye(n); % covariance of measurement �������̵�Э����

f=@(x)[x(1)+k/51.];      % nonlinear state equations ������״̬����

h=@(x)[measure_bzt(x(1))];                          % measurement equation ��������

aa0=1.; % ��״��볤��ʼֵ
s=[aa0];
x=s+q*randn;         % initial state % initial state with noise ��ʼ��״̬����������
P = eye(n);          % initial state covraiance Э�����ʼ״̬
N = 30;                % total dynamic steps ��̬��������
xV = zeros(1,N);     % estmate % allocate memory  ���ƣ������ڴ�
sV = zeros(1,N);     % actual ʵ��
zV = zeros(1,N);

ssT = zeros(1,N);    % The true radius of sphere (true state) �������ʵ�뾶����ʵ״̬��
nois=0.3;
dL=0.02; % ��״��볤����ֵ
for k=1:N
    aa1=(aa0+k*dL)*(1+nois*(randn-0.5));
    
    ssT(:,k)=aa1;
    zz=noise_bzt(aa1);
    z=zz+r*randn;
    sV(:,k)= s;          % save actual state ����ʵ��״̬
    zV(:,k) = z;         % save measurment �������״̬
    [x, P] = ekf(f,x,P,h,z,Q,R); % ukf
    xV(:,k) = x;            % save estimate �������״̬
    s = f(s) + q*randn;     % update process ���´���
end

subplot(4,1,1);
plot(1:N, ssT(1,:),'b--', 1:N, xV(1,:),'r-','LineWidth',2);
legend('��״����ʵ�볤','��״��Kalman����ֵ��״̬��')
title('�������˲���ʵֵ�����ֵ�Ա�')
xlabel('ʱ�䲽��')
ylabel('��״��볤��m��')
grid on;

for i=1:size(ssT,2)
    % �޸�ģ�͵Ļ�����Ҫ�޸ģ�����measure��noise��Ҫ�޸ģ��ұ���һ��
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
        legend('��30%������ģ��۲�����','��״�巴��ģ������','Location','northoutside','Orientation','horizontal')
        title(strcat('ʱ�䲽��Ϊ��',num2str(i),'ʱ��״��ģ�ͷ���Ч���Ա�'))
        xlabel('����λ��(m)')
        ylabel('��λ�mV��')
        grid on;
    end

    
end
