%%
tic
clc
clear
%����ѵ�������������
load forwarddata_Three
load model_three
input_train=forwarddata(1:800,:)';
output_train=model(1:800,:)';
input_test=forwarddata(801:1024,:)';
output_test=model(801:1024,:);
%ѵ�����ݹ�һ��
[inputn,ps1]=mapminmax(input_train);
[outputn,ps2]=mapminmax(output_train);
%%
%BP�����繹��
net=newff(inputn,outputn,[50],{'tansig'},'trainlm');
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
save BPinversemodel_Three BPinversemodel
xlswrite('C:\Users\Administrator\Desktop\TEM_1DBP_INV\Threelayers\����ģ������.xlsx',BPinversemodel);
toc
