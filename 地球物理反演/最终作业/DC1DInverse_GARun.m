clear
clc

%先正演得到场值
rho_i=[10,100,10];
h_i=[500,300];
r=logspace(1,4,40);
rhos=DC1D_Forward(rho_i,h_i);
%加入噪声
rhos=rhos+0.05.*(-1+2.*rand(size(rhos))).*rhos;
% rhos=[33.9900000000000,33.7200000000000,33.6700000000000,33.4800000000000,33.3200000000000,33.2400000000000,32.2900000000000,32.8300000000000,32.7700000000000,32.8700000000000,32.8700000000000,32.8000000000000,32.9400000000000,32.6500000000000,32.2700000000000,31.7400000000000,31.4200000000000,31.2000000000000,31.2300000000000,31.4800000000000,32.0600000000000,32.3100000000000,32.6700000000000,32.7000000000000,32.6300000000000,32.8700000000000,32.9400000000000,33.0300000000000,33.2600000000000,33.3600000000000,33.4900000000000,33.7200000000000,33.9600000000000,34.2800000000000,34.8600000000000,35.2400000000000];
e=1;
LayerNumber=3;
% e=0.1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   遗传参数设置
length=[10,10,10,12,12];
a=[0,150,0,450,250];
b=[20,250,20,550,350];

p=0.2;  %定义前30%为精英，不参与交叉变异，值的范围在0-1之间
CrossoverProbability=0.6; %交叉概率
MutationProbability=1; %变异概率
PopulationSize=50; %群体大小

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     遗传算法主体
PopulationLength=sum(length); %字符串长度（个体长度）
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %随机产生初始群体
k=1;
while(e>0.03)
    tic
    TargetFunctionValue  = TargetFunction( rhos,PopulationParent,length,a,b ,LayerNumber );         %计算父代群体目标函数值
    FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %计算父代群体的适値
    [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %精英选择
    PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %选择复制
    PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %交叉
    PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %变异
    PopulationChild=[PopulationSave;PopulationMutate];                                   %组成新子代
    ChildTargetFunctionValue  = TargetFunction( rhos,PopulationChild,length,a,b,LayerNumber);         %计算子代群体的目标函数
    FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %计算子代群体的适値
    [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %计算最大适値及其所对应的个体
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          解码进行计算误差

     lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
    e(k)=norm(log2(rhos)-log2(DC1D_Forward(lambda(k,1:LayerNumber),lambda(k,LayerNumber+1:end))));
    figure(1)
    plot(e,'-*')
    title('目标函数变化曲线')
    xlabel('迭代次数')
    ylabel('目标函数值')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        进行下一次迭代
    disp(k)
    disp(e(end))
    k=k+1;
    PopulationParent=PopulationChild;
    if(k>200)
        break
    end
    toc
end

figure(2)
semilogx(r,rhos,'b--o','LineWidth',1.5);
hold on
rhos1=DC1D_Forward(rho_i,h_i);
semilogx(r,rhos1,'k--p','LineWidth',1.5);
index=find(e==min(e));
rhos1=DC1D_Forward(lambda(index(1),1:LayerNumber),lambda(index(1),LayerNumber+1:end));
semilogx(r,rhos1,'r--+','LineWidth',1.5)
title('对称四极装置电测深的遗传算法一维反演对比')
xlabel('AB/2(m)')
ylabel('视电阻率\rho_a/(\Omega·m)')
legend('理论模型正演并加入随机噪声的曲线','理论模型正演曲线','遗传算法反演模型正演曲线',0)
grid off

figure(3)
% 绘制模型对比阶梯图
hhh=cumsum(h_i);
h=[1,hhh,2*(hhh(end))];
rho=[rho_i,rho_i(end)];
stairs(h,rho,'b-*','LineWidth',1.5);
hold on
lambda2=cumsum(lambda(index(1),LayerNumber+1:end));
h1=[1,lambda2,2*(lambda2(end))];
rho1=[lambda(index(1),1:LayerNumber),lambda(index(1),LayerNumber)];
stairs(h1,rho1,'r--o','LineWidth',1.5);
set(gca, 'XLim',[0 2*(lambda2(end))]);set(gca, 'YLim',[0 max(rho1)+5]);
xlabel('深度Depth/m')
ylabel('视电阻率\rho_a/(\Omega·m)')
title('遗传算法反演模型与实际模型对比');
legend('理论模型','反演模型',0);