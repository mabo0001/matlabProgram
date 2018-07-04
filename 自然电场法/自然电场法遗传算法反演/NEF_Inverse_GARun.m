clear
clc

%% �����ݵõ���ֵ
x=-60:60;
theta=40*pi/180;
z=4;
x0=0;
q=1;
K_LQT=150;
V_LQT= NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );
%%  ������
zaosheng=0.2;
V_LQT_withNoise=V_LQT+zaosheng.*(-1+2.*rand(size(V_LQT))).*V_LQT;
e=1;
%%   �Ŵ���������

length=[10,10,10,10,10];
a=[30*pi/180,0.5,0,-5,100]; 
b=[50*pi/180,1.5,8,5,150];

p=0.2;  %����ǰ30%Ϊ��Ӣ�������뽻����죬ֵ�ķ�Χ��0-1֮��
CrossoverProbability=0.6; %�������
MutationProbability=1; %�������
PopulationSize=200; %Ⱥ���С
MAX_ITERATIVE=200; % ����������

%%     �Ŵ��㷨����
PopulationLength=sum(length); %�ַ������ȣ����峤�ȣ�
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %���������ʼȺ��
k=1;
while(e>0.05)
    tic
    TargetFunctionValue  =TargetFunction( V_LQT_withNoise,PopulationParent,length,a,b,x ) ;         %���㸸��Ⱥ��Ŀ�꺯��ֵ
    FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %���㸸��Ⱥ����ʂ�
    [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %��Ӣѡ��
    PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %ѡ����
    PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %����
    PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %����
    PopulationChild=[PopulationSave;PopulationMutate];                                   %������Ӵ�
    ChildTargetFunctionValue  =TargetFunction( V_LQT_withNoise,PopulationChild,length,a,b,x ) ;         %�����Ӵ�Ⱥ���Ŀ�꺯��
    FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %�����Ӵ�Ⱥ����ʂ�
    [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %��������ʂ���������Ӧ�ĸ���
    %%          ������м������

     lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
    e(k)=norm(log2(V_LQT_withNoise)-log2(NEF_forward_leiqiuti( x,lambda(k,1),lambda(k,2),lambda(k,3),lambda(k,4),lambda(k,5))));
%     figure(1)
%     plot(e,'-*')
% %     title('Ŀ�꺯���仯����')
%     xlabel('Iteration number')
%     ylabel('The value of objective function ')
    %%         ������һ�ε���
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