% 2.8 ������
%�Ŵ��㷨������
%Name:genmain05.m
clear

clc
T=logspace(-3,4,100);
%�����ݵõ���ֵ
rho=[150,180,130];
h=[180,190];
lambda1=[rho,h];
rhos=mt1d(lambda1);
e=1;


popsize=50; %Ⱥ���С
chromlength=15*5; %�ַ������ȣ����峤�ȣ�
pc=0.6; %�������
% pm=0.001; %�������
pm=0.6;
pop=initpop(popsize,chromlength); %���������ʼȺ��
i=1;
while(e>0.001)
    
    [objvalue]=calobjvalue(rhos,pop); %����Ŀ�꺯��
    fitvalue=calfitvalue(objvalue); %����Ⱥ����ÿ���������Ӧ��
    
    [newpop]=selection(pop,fitvalue); %����
    [newpop1]=crossover(newpop,pc); %����
    [newpop2]=mutation(newpop1,pm); %����
    
    [objvalue]=calobjvalue(rhos,newpop2); %����Ŀ�꺯��
    fitvalue=calfitvalue(objvalue); %����Ⱥ����ÿ���������Ӧ��
    
    [bestindividual,bestfit]=best(newpop2,fitvalue); %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ
    
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
title('�Ŵ��㷨MTһά���ݶԱ�')
xlabel('ʱ��T/s')
ylabel('�ӵ�����')
legend('ԭʼģ����������','�Ŵ��㷨��������',0)
% fplot('10*sin(5*x)+7*cos(4*x)',[0 10])
% hold on
% plot(x,y,'r*')
% hold off

% [z index]=max(y); %�������ֵ����λ��
% x5=x(index)%�������ֵ��Ӧ��xֵ
% y=z

% figure(2)
% x0=0:0.01:10;
% for i=1:length(x0)
%     yy(i)=F_target(x0(i));
% end
% plot(x0,yy)