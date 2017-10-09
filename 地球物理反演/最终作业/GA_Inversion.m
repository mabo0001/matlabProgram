function  GA_Inversion( handles,lambda_GAzy,noise,length,min,max,factor,jiaocha,bianyi,qtSize,kmax,LayerNumber )
%   DC1D 遗传算法反演程序
%   此处显示详细说明
%先正演得到场值

r=logspace(1,4,40);
rhos=DC1D_Forward(lambda_GAzy(1:LayerNumber),lambda_GAzy(LayerNumber+1:end));
%加入噪声
rhos=rhos+noise.*(-1+2.*rand(size(rhos))).*rhos;
e=1;
% LayerNumber=3;
% e=0.1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   遗传参数设置
% length=[10,10,10,12,12];
a=min;
b=max;

p=factor;  %定义前30%为精英，不参与交叉变异，值的范围在0-1之间
CrossoverProbability=jiaocha; %交叉概率
MutationProbability=bianyi; %变异概率
PopulationSize=qtSize; %群体大小

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     遗传算法主体
PopulationLength=sum(length); %字符串长度（个体长度）
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %随机产生初始群体
k=1;
while(e>0.01)
%     tic
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
          axes(handles.axes1);
    plot(e,'-*')
    title('目标函数变化曲线')
    xlabel('迭代次数')
    ylabel('目标函数值')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        进行下一次迭代
%     disp(k)
%     disp(e(end))
    k=k+1;
    PopulationParent=PopulationChild;
    if(k>kmax)
        break
    end
%     toc
end

      axes(handles.axes2);
semilogx(r,rhos,'b--*','LineWidth',1.5);
hold on
rhos1=DC1D_Forward(lambda_GAzy(1:LayerNumber),lambda_GAzy(LayerNumber+1:end));
semilogx(r,rhos1,'k--p','LineWidth',1.5);
% index=find(e==min(e));
rhos1=DC1D_Forward(lambda(end,1:LayerNumber),lambda(end,LayerNumber+1:end));
semilogx(r,rhos1,'r--+','LineWidth',1.5)
title('对称四极装置电测深的遗传算法一维反演对比')
xlabel('AB/2(m)')
ylabel('视电阻率\rho_a/(\Omega·m)')
legend('理论模型正演并加入随机噪声的曲线','理论模型正演曲线','遗传算法反演模型正演曲线',0)
grid off

      axes(handles.axes3);
% 绘制模型对比阶梯图
hhh=cumsum(lambda_GAzy(LayerNumber+1:end));
h=[1,hhh,2*(hhh(end))];
rho=[lambda_GAzy(1:LayerNumber),lambda_GAzy(LayerNumber)];
stairs(h,rho,'b-*','LineWidth',1.5);
hold on
lambda2=cumsum(lambda(end,LayerNumber+1:end));
h1=[1,lambda2,2*(lambda2(end))];
rho1=[lambda(end,1:LayerNumber),lambda(end,LayerNumber)];
stairs(h1,rho1,'r--o','LineWidth',1.5);
xlabel('深度Depth/m')
ylabel('视电阻率\rho_a/(\Omega·m)')
title('遗传算法反演模型与实际模型对比');
legend('理论模型','反演模型',0);
% set(gca, 'XLim',[0 2*(h1(end))]);set(gca, 'YLim',[0 max(rho1)+5]);

end

