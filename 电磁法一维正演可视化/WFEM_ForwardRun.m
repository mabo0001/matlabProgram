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
I = 10;                             %供电电流
DL = 1e3;                           %AB极长度(米)
PE = I * DL / 2 / pi;
fmin=-8;
fmax=13;
fo=fmin:0.5:fmax;
f=2.^fo;                             %频率系列

[ex,hy,rho,rho_r,phase,ex0,ex2]=CSAMT_forward(rho_i,h_i,x,y,f,PE);        %进行CSAMT正演
%%
a0=20;                  %设置模型的初始值，分别是厚度和电阻率.
al=1;                   %设置下界
au=1e6;                 %设置上界
%%%%%%%%%%%%%%CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC最小二乘拟合
for i=1:length(ex)
options=optimset('lsqnonlin');      %设置优化选项参数，选择非线性最小二乘法
options.LevenbergMarquardt='on';    %设置优化选项参数，选择LevenbergMarquardt法，为缺省选项，也可以选择Guass-Newton
options.Display='off';              %设置显示参数，iter为显示每一步，off为不显示，final为显示最后一步
options.MaxFunEvals=100;          %设置优化选项参数，允许函数计算的最多次数，缺省为自变量的100倍，
options.MaxIter=100;                %设置优化选项参数，最大迭代次数，缺省为400次
options.TolFun=1e-20;               %设置优化选项参数，函数值计算的终止误差，缺省为1e-6
options.TolX=1e-20;                 %设置优化选项参数，自变量计算的终止容差，缺省为1e-6
[a(i),resnorm,residual,exitflag,output]=lsqnonlin(@CSAMT_halfspace,a0,al,au,options,i);   %进行最小二乘法拟合，exitflag：终止计算条件，若是收敛后退出，小于0
end
%%%%%%%%%%%%%%CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC最小二乘拟合

loglog(f,a,'-r','LineWidth',1.5);
title('广域电磁法一维正演视电阻率曲线','Fontsize',10,'Fontweight','bold')
xlabel('f/Hz','Fontsize',10,'Fontweight','bold');
ylabel('\rho_a/(\Omega·m)','Fontsize',10,'Fontweight','bold');
grid on
set(gca,'XDir','reverse')