clear
clc

global x
global y
global f
global ex
global hy
global PE

rho_i=[100,10,100];
h_i=[500,300];
x=0;
y=10000;
I = 10;                             %�������
DL = 1e3;                           %AB������(��)
PE = I * DL / 2 / pi;
fmin=-8;
fmax=13;
fo=fmin:0.5:fmax;
f=2.^fo;                             %Ƶ��ϵ��

[ex,hy,rho,rho_r,phase,ex0,ex2]=CSAMT_forward(rho_i,h_i,x,y,f,PE);        %����CSAMT����
%%
a0=20;                  %����ģ�͵ĳ�ʼֵ���ֱ��Ǻ�Ⱥ͵�����.
al=1;                   %�����½�
au=1e6;                 %�����Ͻ�
%%%%%%%%%%%%%%CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC��С�������
for i=1:length(ex)
options=optimset('lsqnonlin');      %�����Ż�ѡ�������ѡ���������С���˷�
options.LevenbergMarquardt='on';    %�����Ż�ѡ�������ѡ��LevenbergMarquardt����Ϊȱʡѡ�Ҳ����ѡ��Guass-Newton
options.Display='off';              %������ʾ������iterΪ��ʾÿһ����offΪ����ʾ��finalΪ��ʾ���һ��
options.MaxFunEvals=100;          %�����Ż�ѡ��������������������������ȱʡΪ�Ա�����100����
options.MaxIter=100;                %�����Ż�ѡ�������������������ȱʡΪ400��
options.TolFun=1e-20;               %�����Ż�ѡ�����������ֵ�������ֹ��ȱʡΪ1e-6
options.TolX=1e-20;                 %�����Ż�ѡ��������Ա����������ֹ�ݲȱʡΪ1e-6
[a(i),resnorm,residual,exitflag,output]=lsqnonlin(@CSAMT_halfspace,a0,al,au,options,i);   %������С���˷���ϣ�exitflag����ֹ���������������������˳���С��0
end
%%%%%%%%%%%%%%CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC��С�������

loglog(f,a,'-r','LineWidth',1.5);
title('�����ŷ�һά�����ӵ���������','Fontsize',10,'Fontweight','bold')
xlabel('f/Hz','Fontsize',10,'Fontweight','bold');
ylabel('\rho_a/(\Omega��m)','Fontsize',10,'Fontweight','bold');
grid on
set(gca,'XDir','reverse')