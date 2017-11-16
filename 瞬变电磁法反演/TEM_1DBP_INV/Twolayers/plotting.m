%%
%计算均方误差Mse
load forwarddata_Two.mat
load BPinversedata_Two.mat
% mse=((forwarddata(801:1000,:)-BPinversedata)./BPinversedata).^2;
% Mse=1/2.*sum(mse');
% Mse=Mse';
% xlswrite('C:\Users\Administrator\Desktop\matlab神经网络\TEM_1DBP_INV\Twolayers\均方误差.xlsx',Mse);
%%
%网络预测结果图形
figure
t=logspace(-7,-2,50);
V1=forwarddata(806,:);
V2=BPinversedata(6,:);
loglog(t,V1,'b-');
hold on
loglog(t,V2,'or');
legend('期望输出','预测输出');
xlabel('时间 / s','fontsize',12)
ylabel('电压/ V','fontsize',12)
title('BP网络预测输出','fontsize',12)
% %% 
% %均方误差图
% figure
% bar(1:200,Mse);
% title('均方误差图','fontsize',12)
% ylabel('均方误差','fontsize',12)
% xlabel('样本序号','fontsize',12)
