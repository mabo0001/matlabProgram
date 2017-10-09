% 2.8 主程序
%遗传算法主程序
%Name:genmain05.m
clear
clf
popsize=20; %群体大小
chromlength=10; %字符串长度（个体长度）
pc=0.6; %交叉概率
% pm=0.001; %变异概率
pm=0.2;
pop=initpop(popsize,chromlength); %随机产生初始群体
for i=1:20 %20为迭代次数
    [objvalue]=calobjvalue(pop); %计算目标函数
    fitvalue=calfitvalue(objvalue); %计算群体中每个个体的适应度
    
    [newpop]=selection(pop,fitvalue); %复制
    [newpop1]=crossover(newpop,pc); %交叉
    [newpop2]=mutation(newpop1,pm); %变异
    
    [objvalue]=calobjvalue(newpop2); %计算目标函数
    fitvalue=calfitvalue(objvalue); %计算群体中每个个体的适应度
    
    [bestindividual,bestfit]=best(newpop2,fitvalue); %求出群体中适应值最大的个体及其适应值
    y(i)=max(bestfit);
    n(i)=i;
    pop5=bestindividual;
    x(i)=decodechrom(pop5,1,chromlength)*10/1023;
    pop=newpop2;
end

fplot('10*sin(5*x)+7*cos(4*x)',[0 10])
hold on
plot(x,y,'r*')
hold off

[z index]=max(y); %计算最大值及其位置
x5=x(index)%计算最大值对应的x值
y=z

figure(2)
x0=0:0.01:10;
for i=1:length(x0)
    yy(i)=F_target(x0(i));
end
plot(x0,yy)