clear
clc
Data_xls=xlsread('D:\�о����׶�ѧϰ\������\ˮ����������ȶ������۵��͹���ʵ��ѵ������.xlsx');
Data_Input=Data_xls(:,5:9)';
Data_Output=Data_xls(:,10:11)';
net=newff([-1 1;-1 1;-1 1;-1 1;-1 1;],[10 2],{'logsig','purelin'});
net.trainParam.epochs=1000;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.5;
net=train(net,Data_Input,Data_Output);

Data_Test=xlsread('D:\�о����׶�ѧϰ\������\ˮ����������ȶ������۵��͹���ʵ��ѵ������.xlsx');
Data_Test=Data_Test(:,5:9)';
R=sim(net,Data_Test)';
R(:,3:4)=Data_Output';
R(:,2)=round(R(:,2));