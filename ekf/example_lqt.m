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

h=@(x)[measure_lqt(x(1))];                          % measurement equation ��������

aa0=1.;
s=[aa0];
x=s+q*randn;         % initial state % initial state with noise ��ʼ��״̬����������
P = eye(n);          % initial state covraiance Э�����ʼ״̬
N = 30;                % total dynamic steps ��̬��������
xV = zeros(1,N);     % estmate % allocate memory  ���ƣ������ڴ�
sV = zeros(1,N);     % actual ʵ��
zV = zeros(1,N);

ssT = zeros(1,N);    % The true radius of sphere (true state) �������ʵ�뾶����ʵ״̬��
nois=0.1; % ģ������
dr=0.02; % ��״��볤����ֵ
for k=1:N
    aa1=(aa0+k*dr)*(1+nois*(randn-0.5));
    
    ssT(:,k)=aa1;
    zz=noismeas_lqt(aa1);
    z=zz+r*randn;
    sV(:,k)= s;          % save actual state ����ʵ��״̬
    zV(:,k) = z;         % save measurment �������״̬
    [x, P] = ekf(f,x,P,h,z,Q,R); % ukf
    xV(:,k) = x;                 % save estimate �������״̬
    s = f(s) + q*randn;     % update process ���´���
end

figure(1);
plot(1:N, ssT(1,:), 1:N, xV(1,:));
legend('�������ʵ�뾶����ʵ״̬��','����Kalman����ֵ��״̬��')
grid on;

figure(2);
for i=1:size(ssT,2)
    % �޸�ģ�͵Ļ�����Ҫ�޸ģ�����measure��noise��Ҫ�޸ģ��ұ���һ��
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
        legend('��10%������ģ��۲�����','�����巴��ģ������','Location','southwest')
        title(strcat('ʱ�䲽��Ϊ��',num2str(i),'ʱ������ģ�ͷ���Ч���Ա�  ��ϲ',num2str(nihecha)))
        xlabel('����λ��(m)')
        ylabel('��λ�mV��')
        grid on;
    end

    
end

