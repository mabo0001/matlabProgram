%%
tic
clc
clear
%下载训练输入输出数据
load forwarddata_Two
load model_two
% for i=1:200
%     input_test(i,:)=forwarddata(5*(i-1)+1,:);
%     output_test(i,:)=model(5*(i-1)+1,:);
    
input_train=forwarddata(1:800,:)';
output_train=model(1:800,:)';
input_test=forwarddata(801:1000,:)';
output_test=model(801:1000,:);
%训练数据归一化
[inputn,ps1]=mapminmax(input_train);
[outputn,ps2]=mapminmax(output_train);
%%
%BP神经网络构建
net=newff(inputn,outputn,[20,20],{'tansig','tansig'},'trainlm');
net.trainParam.epochs=500;
net.trainParam.show=10;
net.trainParam.lr=0.01;
net.trainParam.goal=0.00005;
net=train(net,inputn,outputn);
%%
%BP神经网络预测输出
inputn_test=mapminmax('apply',input_test,ps1);
BPoutputn=sim(net,inputn_test);
BPoutput=mapminmax('reverse',BPoutputn,ps2);
BPinversemodel=BPoutput';
save BPinversemodel_Two BPinversemodel

toc
