clear
clc
Data_xls=xlsread('D:\研究生阶段学习\神经网络\RBF神经网络边坡训练数据.xlsx');
[Data_Input26,ps]=mapminmax(Data_xls(:,2:6));
Data_Input=[Data_Input26 Data_xls(:,7)]';
Data_Output=Data_xls(:,8)';

net=newff([-1 1;-1 1;-1 1;-1 1;-1 1;-1 1;],[10 1],{'logsig','purelin'});
net.trainParam.epochs=1000;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.5;
net=train(net,Data_Input,Data_Output);

Data_Test=Data_xls(:,2:6);
data_t=mapminmax('apply',Data_Test,ps);
Data_Test_Input=[data_t Data_xls(:,7)]';
R=sim(net,Data_Test_Input);
R(2,:)=Data_Output;
err=0;
for i=1:size(R,2)
    err=err+R(2,i)-R(1,i);
end
err=err/size(R,2);
R=R';
