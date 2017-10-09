%% �ϼұ���ʦ�ڶ�����ҵ�ڶ���
clc
clear
%% ����ѵ����
x=-10:0.1:10;
[x1,y1]=meshgrid(x);
x1=x1(:)';
y1=y1(:)';
z1=x1.^2+2*y1.^2;
[Data_Input,ps]=mapminmax([x1;y1]);
%% ������ѵ��BP����
net=newff([-1 1;-1 1],[5 1],{'logsig','purelin'});
net.trainParam.epochs=1000;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.5;
net=train(net,Data_Input,z1);
%% ��ͼ
subplot(1,2,1)
[X,Y]=meshgrid(x);
z=X.^2+2*Y.^2;
mesh(X,Y,z)
xlabel('x');
ylabel('y');
zlabel('z');
title('ʵ��ͼ��')
hold on
%% ʹ������
p=-10:0.01:10;
[px,py]=meshgrid(p);
px1=px(:)';
py1=py(:)';
Data_test=[px1;py1];
data_t=mapminmax('apply',Data_test,ps);
R=sim(net,data_t);
Data_Output=reshape(R,size(px));
%% ��ͼ
subplot(1,2,2);
mesh(px,py,Data_Output);
xlabel('x');
ylabel('y');
zlabel('z');
title('����ѵ���������ͼ��')
