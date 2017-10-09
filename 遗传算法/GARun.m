% 2.8 ������
%�Ŵ��㷨������
%Name:genmain05.m
clear
clf
popsize=20; %Ⱥ���С
chromlength=10; %�ַ������ȣ����峤�ȣ�
pc=0.6; %�������
% pm=0.001; %�������
pm=0.2;
pop=initpop(popsize,chromlength); %���������ʼȺ��
for i=1:20 %20Ϊ��������
    [objvalue]=calobjvalue(pop); %����Ŀ�꺯��
    fitvalue=calfitvalue(objvalue); %����Ⱥ����ÿ���������Ӧ��
    
    [newpop]=selection(pop,fitvalue); %����
    [newpop1]=crossover(newpop,pc); %����
    [newpop2]=mutation(newpop1,pm); %����
    
    [objvalue]=calobjvalue(newpop2); %����Ŀ�꺯��
    fitvalue=calfitvalue(objvalue); %����Ⱥ����ÿ���������Ӧ��
    
    [bestindividual,bestfit]=best(newpop2,fitvalue); %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ
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

[z index]=max(y); %�������ֵ����λ��
x5=x(index)%�������ֵ��Ӧ��xֵ
y=z

figure(2)
x0=0:0.01:10;
for i=1:length(x0)
    yy(i)=F_target(x0(i));
end
plot(x0,yy)