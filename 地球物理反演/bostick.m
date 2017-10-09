function [H,rhoh]= bostick( rhos, phase)
% bostick反演
%   此处显示详细说明
T=logspace(-3,4,40);
mu=(4e-7)*pi;
H=sqrt(rhos./(2*pi*mu.*(1./T)));%bostick反演H
rhoh=rhos.*(180./(2*phase)-1);%bostick反演rhos
h=stairs(H/1000,rhoh);%绘制bostick反演模型
set(h,'color','r')
set(gca,'xscale','log');%设置坐标轴为对数坐标
set(gca,'yscale','log');
title('bostick反演结果')
xlabel('深度（Km)');
ylabel('电阻率\rho_{s}(\Omega\cdot m)');
h=diff(H);%bostick反演的层厚度
[rhos1,phase1]=MT1D_zhengyan(rhoh,h);%将bostick反演得到的模型进行正演
figure(2);%选择第二个窗口
semilogx((1./T),rhos,'*');%绘制原始模型电阻率随频率变化曲线
hold on
semilogx((1./T),rhos1,'r');%绘制bostick反演模型电阻率随频率变化曲线
title('bostick反演电阻率响应对比')
xlabel('f(Hz)');
ylabel('\rho_{s}(\Omega\cdotm)')
legend('原始模型响应','反演模型响应',0);
set(gca,'xscale','log');



end

