clear
clc

%% 先正演得到场值
x=-60:60;
theta=40*pi/180;
z=4;
x0=0;
q=1;
K_LQT=150;
V_LQT= NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );
%%  加噪声
zaosheng=0.2;
V_LQT_withNoise=V_LQT+zaosheng.*(-1+2.*rand(size(V_LQT))).*V_LQT;
e=1;
%%   遗传参数设置

length=[10,10,10,10,10];
a=[30*pi/180,0.5,0,-5,100]; 
b=[50*pi/180,1.5,8,5,150];

p=0.2;  %定义前30%为精英，不参与交叉变异，值的范围在0-1之间
CrossoverProbability=0.6; %交叉概率
MutationProbability=1; %变异概率
PopulationSize=200; %群体大小
MAX_ITERATIVE=200; % 最大迭代次数

%%     遗传算法主体
PopulationLength=sum(length); %字符串长度（个体长度）
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %随机产生初始群体
k=1;
while(e>0.05)
    tic
    TargetFunctionValue  =TargetFunction( V_LQT_withNoise,PopulationParent,length,a,b,x ) ;         %计算父代群体目标函数值
    FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %计算父代群体的适値
    [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %精英选择
    PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %选择复制
    PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %交叉
    PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %变异
    PopulationChild=[PopulationSave;PopulationMutate];                                   %组成新子代
    ChildTargetFunctionValue  =TargetFunction( V_LQT_withNoise,PopulationChild,length,a,b,x ) ;         %计算子代群体的目标函数
    FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %计算子代群体的适値
    [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %计算最大适値及其所对应的个体
    %%          解码进行计算误差

     lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
    e(k)=norm(log2(V_LQT_withNoise)-log2(NEF_forward_leiqiuti( x,lambda(k,1),lambda(k,2),lambda(k,3),lambda(k,4),lambda(k,5))));
%     figure(1)
%     plot(e,'-*')
% %     title('目标函数变化曲线')
%     xlabel('Iteration number')
%     ylabel('The value of objective function ')
    %%         进行下一次迭代
    disp(k)
    disp(e(end))
    k=k+1;
    PopulationParent=PopulationChild;
    if(k>MAX_ITERATIVE)
        break
    end
    toc
end

figure(2)
plot(x,V_LQT_withNoise,'b--','LineWidth',1.5);
hold on
V_LQT_withoutNoise=NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );
plot(x,V_LQT_withoutNoise,'k--','LineWidth',1.5)
index=find(e==min(e));
V_LQT_GA=NEF_forward_leiqiuti( x,lambda(index(1),1),lambda(index(1),2),lambda(index(1),3),lambda(index(1),4),lambda(index(1),5) );
plot(x,V_LQT_GA,'r--','LineWidth',1.5)
xlabel('X')
ylabel('V')
legend('The curve of Theoretical Model with noise','The curve of Theoretical Model without noise','The curve of GA-Inversional Model','Location','northeast')
disp(lambda(index(1),:))