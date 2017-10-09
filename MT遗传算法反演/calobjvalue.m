% 2.2.3 计算目标函数值
% calobjvalue.m函数的功能是实现目标函数的计算，其公式采用本文示例仿真，可根据不同优化问题予以修改。
%遗传算法子程序
%Name: calobjvalue.m
%实现目标函数的计算
function [objvalue]=calobjvalue(rhos,pop)
% lambda1=pop(:,1:15);
% lambda2=pop(:,16:30);
% lambda3=pop(:,31:45);
% lambda4=pop(:,46:60);
% lambda5=pop(:,61:75);
% 
% temp1=100+decodechrom(lambda1,1,15)*100/(2^15-1); %将pop每行转化成十进制数  %将二值域 中的数转化为变量域 的数
% temp2=100+decodechrom(lambda2,1,15)*100/(2^15-1); %将pop每行转化成十进制数  %将二值域 中的数转化为变量域 的数
% temp3=100+decodechrom(lambda3,1,15)*100/(2^15-1); %将pop每行转化成十进制数  %将二值域 中的数转化为变量域 的数
% temp4=100+decodechrom(lambda4,1,15)*100/(2^15-1); %将pop每行转化成十进制数  %将二值域 中的数转化为变量域 的数
% temp5=100+decodechrom(lambda5,1,15)*100/(2^15-1); %将pop每行转化成十进制数  %将二值域 中的数转化为变量域 的数
% 
% lambda=[temp1,temp2,temp3,temp4,temp5];
lambda = DecodeToModel( pop,[15,15,15,15,15] );

for i=1:size(pop,1)
    objvalue(i)=F_target(rhos,lambda(i,:)); %计算目标函数值
end
objvalue=objvalue';