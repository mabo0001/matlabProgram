%%
tic
clc
clear
%����ѵ�������������
load forwarddata_Two
load model_two
% for i=1:200
%     input_test(i,:)=forwarddata(5*(i-1)+1,:);
%     output_test(i,:)=model(5*(i-1)+1,:);
    
input_train=forwarddata(1:800,:)';
output_train=model(1:800,:)';
input_test=forwarddata(801:1000,:)';
output_test=model(801:1000,:);
%ѵ�����ݹ�һ��
[inputn,ps1]=mapminmax(input_train);
[outputn,ps2]=mapminmax(output_train);
%%
%BP�����繹��
net=newff(inputn,outputn,[20,20],{'tansig','tansig'},'trainlm');
net.trainParam.epochs=500;
net.trainParam.show=10;
net.trainParam.lr=0.01;
net.trainParam.goal=0.00005;
net=train(net,inputn,outputn);
%%
%BP������Ԥ�����
inputn_test=mapminmax('apply',input_test,ps1);
BPoutputn=sim(net,inputn_test);
BPoutput=mapminmax('reverse',BPoutputn,ps2);
BPinversemodel=BPoutput';
save BPinversemodel_Two BPinversemodel

toc
