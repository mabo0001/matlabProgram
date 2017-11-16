%%
%计算均方误差Mse
load forwarddata_Three.mat
load BPinversedata_Three.mat
mse=((forwarddata(2526:3125,:)-BPinversedata)./BPinversedata).^2;
Mse=1/2.*sum(mse');
Mse=Mse';
xlswrite('C:\Users\Administrator\Desktop\TEM_1DBP_INV\Threelayers\均方误差.xlsx',Mse);
%%
%网络预测结果图形
figure
t=logspace(-7,-2,50);
V1=forwarddata(2909,:);
loglog(t,V1,'b-');
hold on
V2=BPinversedata(384,:);
loglog(t,V2,'ro');
legend('期望输出','预测输出');
xlabel('时间 / s','fontsize',12)
ylabel('电压 / V','fontsize',12)
title('BP网络预测输出','fontsize',12)
% %% 
% %均方误差图
figure
bar(1:600,Mse);
title('均方误差图','fontsize',12)
ylabel('均方误差','fontsize',12)
xlabel('样本序号','fontsize',12)
