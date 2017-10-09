clear
clc

%先正演得到场值
T=logspace(-3,4,100);
rho=[150,180,130];
h=[180,190];
lambda1=[rho,h];
rhos =mt1d(lambda1);
%加入噪声
rhos=rhos+0.05.*(-1+2.*rand(size(rhos))).*rhos;
e=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   遗传参数设置
length=[30,30,30,30,30];
a=[100,100,100,100,100];
b=[200,200,200,200,200];
p=0.2;  %定义前30%为精英，不参与交叉变异，值的范围在0-1之间
CrossoverProbability=0.6; %交叉概率
MutationProbability=1; %变异概率
PopulationSize=3000; %群体大小

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     遗传算法主体
PopulationLength=sum(length); %字符串长度（个体长度）
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %随机产生初始群体
k=1;
while(e(end)>0.03)
    tic
    TargetFunctionValue  = TargetFunction( rhos,PopulationParent,length,a,b  );         %计算父代群体目标函数值
    FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %计算父代群体的适値
    [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %精英选择
    PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %选择复制
    PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %交叉
    PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %变异
    PopulationChild=[PopulationSave;PopulationMutate];                                   %组成新子代
    ChildTargetFunctionValue  = TargetFunction( rhos,PopulationChild,length,a,b );         %计算子代群体的目标函数
    FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %计算子代群体的适値
    [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %计算最大适値及其所对应的个体
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          解码进行计算误差

     lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
    e(k)=F_target(  rhos,lambda(k,:) );
    figure(1)
    plot(e)
    title('误差变化曲线')
    xlabel('迭代次数')
    ylabel('%')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        进行下一次迭代
    disp(k);disp(e(end));
    k=k+1;
    PopulationParent=PopulationChild;
    if(k>250)
        break
    end
    toc
end

figure(2)
semilogx(T,rhos,'b--','LineWidth',1.5);
hold on
rhos1 =mt1d(lambda1);
semilogx(T,rhos1,'g--','LineWidth',1.5)
index=find(e==min(e));
rhos2=mt1d(lambda(index(1),:));
semilogx(T,rhos2,'r--','LineWidth',1.5)
title('MT遗传算法一维反演对比')
xlabel('时间T/s')
ylabel('视电阻率')
legend('模型正演之后加入噪声的曲线','模型理论正演曲线','遗传算法反演模型正演曲线',0)

figure(3)
% 绘制模型对比阶梯图
hh=[1,h(1),h(1)+h(2),2*(h(1)+h(2))];
rhorho=[rho,rho(end)];
stairs(hh,rhorho,'b-','LineWidth',1.5);
hold on
h1=[1,lambda(index(1),4),lambda(index(1),4)+lambda(index(1),5),2*(lambda(index(1),4)+lambda(index(1),5))];
rho1=[lambda(index(1),1:3),lambda(index(1),3)];
stairs(h1,rho1,'r--o','LineWidth',1.5);
% set(gca, 'XLim',[0 1000]);set(gca, 'YLim',[150 200]);
xlabel('深度Depth/m')
ylabel('视电阻率\rho_a/(\Omega·m)')
title('遗传算法反演模型与实际模型对比');
legend('实际模型','反演模型',0);
