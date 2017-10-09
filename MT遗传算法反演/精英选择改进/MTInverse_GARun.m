clear
clc

%�����ݵõ���ֵ
T=logspace(-3,4,100);
rho=[150,180,130];
h=[180,190];
lambda1=[rho,h];
rhos =mt1d(lambda1);
%��������
rhos=rhos+0.05.*(-1+2.*rand(size(rhos))).*rhos;
e=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   �Ŵ���������
length=[30,30,30,30,30];
a=[100,100,100,100,100];
b=[200,200,200,200,200];
p=0.2;  %����ǰ30%Ϊ��Ӣ�������뽻����죬ֵ�ķ�Χ��0-1֮��
CrossoverProbability=0.6; %�������
MutationProbability=1; %�������
PopulationSize=3000; %Ⱥ���С

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     �Ŵ��㷨����
PopulationLength=sum(length); %�ַ������ȣ����峤�ȣ�
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %���������ʼȺ��
k=1;
while(e(end)>0.03)
    tic
    TargetFunctionValue  = TargetFunction( rhos,PopulationParent,length,a,b  );         %���㸸��Ⱥ��Ŀ�꺯��ֵ
    FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %���㸸��Ⱥ����ʂ�
    [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %��Ӣѡ��
    PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %ѡ����
    PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %����
    PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %����
    PopulationChild=[PopulationSave;PopulationMutate];                                   %������Ӵ�
    ChildTargetFunctionValue  = TargetFunction( rhos,PopulationChild,length,a,b );         %�����Ӵ�Ⱥ���Ŀ�꺯��
    FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %�����Ӵ�Ⱥ����ʂ�
    [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %��������ʂ���������Ӧ�ĸ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          ������м������

     lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
    e(k)=F_target(  rhos,lambda(k,:) );
    figure(1)
    plot(e)
    title('���仯����')
    xlabel('��������')
    ylabel('%')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        ������һ�ε���
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
title('MT�Ŵ��㷨һά���ݶԱ�')
xlabel('ʱ��T/s')
ylabel('�ӵ�����')
legend('ģ������֮���������������','ģ��������������','�Ŵ��㷨����ģ����������',0)

figure(3)
% ����ģ�ͶԱȽ���ͼ
hh=[1,h(1),h(1)+h(2),2*(h(1)+h(2))];
rhorho=[rho,rho(end)];
stairs(hh,rhorho,'b-','LineWidth',1.5);
hold on
h1=[1,lambda(index(1),4),lambda(index(1),4)+lambda(index(1),5),2*(lambda(index(1),4)+lambda(index(1),5))];
rho1=[lambda(index(1),1:3),lambda(index(1),3)];
stairs(h1,rho1,'r--o','LineWidth',1.5);
% set(gca, 'XLim',[0 1000]);set(gca, 'YLim',[150 200]);
xlabel('���Depth/m')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
title('�Ŵ��㷨����ģ����ʵ��ģ�ͶԱ�');
legend('ʵ��ģ��','����ģ��',0);
