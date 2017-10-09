clear
clc

%�����ݵõ���ֵ
rho_i=[10,100,10];
h_i=[500,300];
r=logspace(1,4,40);
rhos=DC1D_Forward(rho_i,h_i);
%��������
rhos=rhos+0.05.*(-1+2.*rand(size(rhos))).*rhos;
% rhos=[33.9900000000000,33.7200000000000,33.6700000000000,33.4800000000000,33.3200000000000,33.2400000000000,32.2900000000000,32.8300000000000,32.7700000000000,32.8700000000000,32.8700000000000,32.8000000000000,32.9400000000000,32.6500000000000,32.2700000000000,31.7400000000000,31.4200000000000,31.2000000000000,31.2300000000000,31.4800000000000,32.0600000000000,32.3100000000000,32.6700000000000,32.7000000000000,32.6300000000000,32.8700000000000,32.9400000000000,33.0300000000000,33.2600000000000,33.3600000000000,33.4900000000000,33.7200000000000,33.9600000000000,34.2800000000000,34.8600000000000,35.2400000000000];
e=1;
LayerNumber=3;
% e=0.1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   �Ŵ���������
length=[10,10,10,12,12];
a=[0,150,0,450,250];
b=[20,250,20,550,350];

p=0.2;  %����ǰ30%Ϊ��Ӣ�������뽻����죬ֵ�ķ�Χ��0-1֮��
CrossoverProbability=0.6; %�������
MutationProbability=1; %�������
PopulationSize=50; %Ⱥ���С

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     �Ŵ��㷨����
PopulationLength=sum(length); %�ַ������ȣ����峤�ȣ�
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %���������ʼȺ��
k=1;
while(e>0.03)
    tic
    TargetFunctionValue  = TargetFunction( rhos,PopulationParent,length,a,b ,LayerNumber );         %���㸸��Ⱥ��Ŀ�꺯��ֵ
    FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %���㸸��Ⱥ����ʂ�
    [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %��Ӣѡ��
    PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %ѡ����
    PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %����
    PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %����
    PopulationChild=[PopulationSave;PopulationMutate];                                   %������Ӵ�
    ChildTargetFunctionValue  = TargetFunction( rhos,PopulationChild,length,a,b,LayerNumber);         %�����Ӵ�Ⱥ���Ŀ�꺯��
    FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %�����Ӵ�Ⱥ����ʂ�
    [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %��������ʂ���������Ӧ�ĸ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          ������м������

     lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
    e(k)=norm(log2(rhos)-log2(DC1D_Forward(lambda(k,1:LayerNumber),lambda(k,LayerNumber+1:end))));
    figure(1)
    plot(e,'-*')
    title('Ŀ�꺯���仯����')
    xlabel('��������')
    ylabel('Ŀ�꺯��ֵ')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        ������һ�ε���
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
title('�Գ��ļ�װ�õ������Ŵ��㷨һά���ݶԱ�')
xlabel('AB/2(m)')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
legend('����ģ�����ݲ������������������','����ģ����������','�Ŵ��㷨����ģ����������',0)
grid off

figure(3)
% ����ģ�ͶԱȽ���ͼ
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
xlabel('���Depth/m')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
title('�Ŵ��㷨����ģ����ʵ��ģ�ͶԱ�');
legend('����ģ��','����ģ��',0);