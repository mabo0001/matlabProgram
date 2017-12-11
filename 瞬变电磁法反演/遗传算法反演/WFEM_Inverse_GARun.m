clear
clc

%先正演得到场值
rho_i=[100,10,100];
h_i=[500,300];
LayerNumber=3;
rhos = TEM1D_forward( rho_i,h_i );
%加入噪声
rhos=rhos+0.1.*(-1+2.*rand(size(rhos))).*rhos;
e=1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   遗传参数设置
% length=[10,10,10,12,12];
% a=[50,0,50,450,250];
% b=[150,20,150,550,350];
% 
% p=0.5;  %定义前30%为精英，不参与交叉变异，值的范围在0-1之间
% CrossoverProbability=0.6; %交叉概率
% MutationProbability=1; %变异概率
% PopulationSize=2; %群体大小
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     遗传算法主体
% PopulationLength=sum(length); %字符串长度（个体长度）
% PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %随机产生初始群体
% k=1;
% while(e>0.05)
%     tic
%     TargetFunctionValue  = TargetFunction( rhos,PopulationParent,length,a,b ,LayerNumber );         %计算父代群体目标函数值
%     FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %计算父代群体的适値
%     [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %精英选择
%     PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %选择复制
%     PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %交叉
%     PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %变异
%     PopulationChild=[PopulationSave;PopulationMutate];                                   %组成新子代
%     ChildTargetFunctionValue  = TargetFunction( rhos,PopulationChild,length,a,b,LayerNumber );         %计算子代群体的目标函数
%     FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %计算子代群体的适値
%     [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %计算最大适値及其所对应的个体
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          解码进行计算误差
% 
%      lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
%     e(k)=norm(log2(rhos)-log2(TEM1D_forward( lambda(k,1:LayerNumber),lambda(k,LayerNumber+1:end))));
%     figure(1)
%     plot(e,'-*')
% %     title('目标函数变化曲线')
%     xlabel('Iteration number')
%     ylabel('The value of objective function ')
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        进行下一次迭代
%     disp(k)
%     disp(e(end))
%     k=k+1;
%     PopulationParent=PopulationChild;
%     if(k>2)
%         break
%     end
%     toc
% end
lambda=[101.221896383187,0.527859237536657,78.0547409579668,496.642246642247,284.505494505495];
figure(2)
plot(rhos,'b--','LineWidth',1.5);
hold on
rhos1=TEM1D_forward( rho_i,h_i);
plot(rhos1,'g--','LineWidth',1.5);
index=find(e==min(e));
rhos2=TEM1D_forward( lambda(index(1),1:LayerNumber),lambda(index(1),LayerNumber+1:end) );
plot(rhos2,'r--','LineWidth',1.5)
% title('广域电磁法的遗传算法一维反演对比')
xlabel('Time/s')
ylabel('Voltage/(V)')
legend('The curve of Theoretical Model with noise','The curve of Theoretical Model without noise','The curve of GA-Inversional Model',0)
% set(gca,'XDir','reverse')
grid off

figure(3)
hhh=cumsum(h_i);
h=[1,hhh,2*(hhh(end))];
rho=[rho_i,rho_i(end)];
stairs(h,rho,'b-*','LineWidth',1.5);
hold on
lambda2=cumsum(lambda(index(1),LayerNumber+1:end));
h1=[1,lambda2,2*(lambda2(end))];
rho1=[lambda(index(1),1:LayerNumber),lambda(index(1),LayerNumber)];
stairs(h1,rho1,'r--o','LineWidth',1.5);
xlabel('Depth/m')
ylabel('\rho_a/(\Omega·m)')
% title('遗传算法反演模型与实际模型对比');
legend('Theoretical Model','Inversional Model',0);
% set(gca, 'XLim',[0 2*(h1(end))]);set(gca, 'YLim',[0 max(rho1)+5]);