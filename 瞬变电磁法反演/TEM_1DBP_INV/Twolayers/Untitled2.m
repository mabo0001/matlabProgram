%%
%����������Mse
load BPinversemodel_Two.mat
load model_two.mat
mse=((model(801:1000,:)-BPinversemodel)./BPinversemodel).^2;
Mse=1/2.*sum(mse');
Mse=Mse';
xlswrite('C:\Users\Administrator\Desktop\TEM_1DBP_INV\Twolayers\�������.xlsx',Mse);
% %%
% %����Ԥ����ͼ��
% figure
% t=logspace(-7,-2,50);
% V1=forwarddata(871,:);
% V2=BPinversedata(71,:);
% loglog(t,V1,'b-');
% hold on
% loglog(t,V2,'or');
% legend('�������','Ԥ�����');
% xlabel('ʱ�� / s','fontsize',12)
% ylabel('��ѹ/ V','fontsize',12)
% title('BP����Ԥ�����','fontsize',12)
%% 
%�������ͼ
figure
bar(1:200,Mse);
title('�������ͼ','fontsize',12)
ylabel('�������','fontsize',12)
xlabel('�������','fontsize',12)