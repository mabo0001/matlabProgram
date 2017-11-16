%%
%����������Mse
load forwarddata_Three.mat
load BPinversedata_Three.mat
mse=((forwarddata(2526:3125,:)-BPinversedata)./BPinversedata).^2;
Mse=1/2.*sum(mse');
Mse=Mse';
xlswrite('C:\Users\Administrator\Desktop\TEM_1DBP_INV\Threelayers\�������.xlsx',Mse);
%%
%����Ԥ����ͼ��
figure
t=logspace(-7,-2,50);
V1=forwarddata(2909,:);
loglog(t,V1,'b-');
hold on
V2=BPinversedata(384,:);
loglog(t,V2,'ro');
legend('�������','Ԥ�����');
xlabel('ʱ�� / s','fontsize',12)
ylabel('��ѹ / V','fontsize',12)
title('BP����Ԥ�����','fontsize',12)
% %% 
% %�������ͼ
figure
bar(1:600,Mse);
title('�������ͼ','fontsize',12)
ylabel('�������','fontsize',12)
xlabel('�������','fontsize',12)
