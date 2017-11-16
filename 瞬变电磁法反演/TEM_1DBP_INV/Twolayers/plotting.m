%%
%����������Mse
load forwarddata_Two.mat
load BPinversedata_Two.mat
% mse=((forwarddata(801:1000,:)-BPinversedata)./BPinversedata).^2;
% Mse=1/2.*sum(mse');
% Mse=Mse';
% xlswrite('C:\Users\Administrator\Desktop\matlab������\TEM_1DBP_INV\Twolayers\�������.xlsx',Mse);
%%
%����Ԥ����ͼ��
figure
t=logspace(-7,-2,50);
V1=forwarddata(806,:);
V2=BPinversedata(6,:);
loglog(t,V1,'b-');
hold on
loglog(t,V2,'or');
legend('�������','Ԥ�����');
xlabel('ʱ�� / s','fontsize',12)
ylabel('��ѹ/ V','fontsize',12)
title('BP����Ԥ�����','fontsize',12)
% %% 
% %�������ͼ
% figure
% bar(1:200,Mse);
% title('�������ͼ','fontsize',12)
% ylabel('�������','fontsize',12)
% xlabel('�������','fontsize',12)
