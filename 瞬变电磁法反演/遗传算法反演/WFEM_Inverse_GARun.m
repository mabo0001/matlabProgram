clear
clc

%�����ݵõ���ֵ
rho_i=[100,10,100];
h_i=[500,300];
LayerNumber=3;
rhos = TEM1D_forward( rho_i,h_i );
%��������
rhos=rhos+0.1.*(-1+2.*rand(size(rhos))).*rhos;
e=1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   �Ŵ���������
% length=[10,10,10,12,12];
% a=[50,0,50,450,250];
% b=[150,20,150,550,350];
% 
% p=0.5;  %����ǰ30%Ϊ��Ӣ�������뽻����죬ֵ�ķ�Χ��0-1֮��
% CrossoverProbability=0.6; %�������
% MutationProbability=1; %�������
% PopulationSize=2; %Ⱥ���С
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     �Ŵ��㷨����
% PopulationLength=sum(length); %�ַ������ȣ����峤�ȣ�
% PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %���������ʼȺ��
% k=1;
% while(e>0.05)
%     tic
%     TargetFunctionValue  = TargetFunction( rhos,PopulationParent,length,a,b ,LayerNumber );         %���㸸��Ⱥ��Ŀ�꺯��ֵ
%     FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %���㸸��Ⱥ����ʂ�
%     [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %��Ӣѡ��
%     PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %ѡ����
%     PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %����
%     PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %����
%     PopulationChild=[PopulationSave;PopulationMutate];                                   %������Ӵ�
%     ChildTargetFunctionValue  = TargetFunction( rhos,PopulationChild,length,a,b,LayerNumber );         %�����Ӵ�Ⱥ���Ŀ�꺯��
%     FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %�����Ӵ�Ⱥ����ʂ�
%     [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %��������ʂ���������Ӧ�ĸ���
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          ������м������
% 
%      lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
%     e(k)=norm(log2(rhos)-log2(TEM1D_forward( lambda(k,1:LayerNumber),lambda(k,LayerNumber+1:end))));
%     figure(1)
%     plot(e,'-*')
% %     title('Ŀ�꺯���仯����')
%     xlabel('Iteration number')
%     ylabel('The value of objective function ')
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        ������һ�ε���
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
% title('�����ŷ����Ŵ��㷨һά���ݶԱ�')
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
ylabel('\rho_a/(\Omega��m)')
% title('�Ŵ��㷨����ģ����ʵ��ģ�ͶԱ�');
legend('Theoretical Model','Inversional Model',0);
% set(gca, 'XLim',[0 2*(h1(end))]);set(gca, 'YLim',[0 max(rho1)+5]);