% 2.8 主程序
%遗传算法主程序
%Name:genmain05.m
clear

clc
T=logspace(-3,4,100);
%先正演得到场值
rho=[150,180,130];
h=[180,190];
lambda1=[rho,h];
rhos=mt1d(lambda1);
e=1;


popsize=50; %群体大小
chromlength=15*5; %字符串长度（个体长度）
pc=0.6; %交叉概率
% pm=0.001; %变异概率
pm=0.6;
pop=initpop(popsize,chromlength); %随机产生初始群体
i=1;
while(e>0.001)
    
    [objvalue]=calobjvalue(rhos,pop); %计算目标函数
    fitvalue=calfitvalue(objvalue); %计算群体中每个个体的适应度
    
    [newpop]=selection(pop,fitvalue); %复制
    [newpop1]=crossover(newpop,pc); %交叉
    [newpop2]=mutation(newpop1,pm); %变异
    
    [objvalue]=calobjvalue(rhos,newpop2); %计算目标函数
    fitvalue=calfitvalue(objvalue); %计算群体中每个个体的适应度
    
    [bestindividual,bestfit]=best(newpop2,fitvalue); %求出群体中适应值最大的个体及其适应值
    
    y(i)=max(bestfit);
    n(i)=i;
    pop5=bestindividual;
%     temp1(i)=100+decodechrom(pop5,1,15)*100/(2^15-1);
%     temp2(i)=100+decodechrom(pop5,16,15)*100/(2^15-1);
%     temp3(i)=100+decodechrom(pop5,31,15)*100/(2^15-1);
%     temp4(i)=100+decodechrom(pop5,46,15)*100/(2^15-1);
%     temp5(i)=100+decodechrom(pop5,61,15)*100/(2^15-1);
%     lambda(i,:)=[temp1(i),temp2(i),temp3(i),temp4(i),temp5(i)];
    
    lambda(i,:)= DecodeToModel( pop5,[15,15,15,15,15] );
    pop=newpop2;
    e(i)=F_target(rhos,lambda(end,:));
    i=i+1;
    figure(1)
    plot(e)
    if(i>1000)
        break
    end
end
figure(2)
semilogx(T,rhos,'b');
hold on
index=find(e==min(e));
rhos1=mt1d(lambda(index,:));
semilogx(T,rhos1,'r-')
title('遗传算法MT一维反演对比')
xlabel('时间T/s')
ylabel('视电阻率')
legend('原始模型正演曲线','遗传算法反演曲线',0)
% fplot('10*sin(5*x)+7*cos(4*x)',[0 10])
% hold on
% plot(x,y,'r*')
% hold off

% [z index]=max(y); %计算最大值及其位置
% x5=x(index)%计算最大值对应的x值
% y=z

% figure(2)
% x0=0:0.01:10;
% for i=1:length(x0)
%     yy(i)=F_target(x0(i));
% end
% plot(x0,yy)