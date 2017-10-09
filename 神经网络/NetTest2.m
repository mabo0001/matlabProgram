%% 严家斌老师第二次作业第二题
clc
clear
%% 构造训练集
x=-10:0.1:10;
[x1,y1]=meshgrid(x);
x1=x1(:)';
y1=y1(:)';
z1=x1.^2+2*y1.^2;
[Data_Input,ps]=mapminmax([x1;y1]);
%% 创建和训练BP网络
net=newff([-1 1;-1 1],[5 1],{'logsig','purelin'});
net.trainParam.epochs=1000;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.5;
net=train(net,Data_Input,z1);
%% 绘图
subplot(1,2,1)
[X,Y]=meshgrid(x);
z=X.^2+2*Y.^2;
mesh(X,Y,z)
xlabel('x');
ylabel('y');
zlabel('z');
title('实际图形')
hold on
%% 使用网络
p=-10:0.01:10;
[px,py]=meshgrid(p);
px1=px(:)';
py1=py(:)';
Data_test=[px1;py1];
data_t=mapminmax('apply',Data_test,ps);
R=sim(net,data_t);
Data_Output=reshape(R,size(px));
%% 绘图
subplot(1,2,2);
mesh(px,py,Data_Output);
xlabel('x');
ylabel('y');
zlabel('z');
title('网络训练后输出的图形')
