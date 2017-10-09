% 2.3 计算个体的适应值
%遗传算法子程序
%Name:calfitvalue.m
%计算个体的适应值
function fitvalue=calfitvalue(objvalue)
global Cmin;
Cmin=0;
[px,py]=size(objvalue);
for i=1:px
%     if objvalue(i)+Cmin>0
%          temp=Cmin+objvalue(i);
%     else
%          temp=0.0;
%     end
%         fitvalue(i)=temp;
        fitvalue(i)=1/abs(objvalue(i)*objvalue(i));
end
fitvalue=fitvalue';