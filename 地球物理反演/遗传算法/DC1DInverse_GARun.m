clear
clc

%�����ݵõ���ֵ
rho_i=[10,100,10];
h_i=[500,300];
length=[12,12,12,12,12];
a=[0,50,0,450,250];
b=[20,150,20,550,350];
noise=0;

r=logspace(1,4,40);
rhos=DC1D_Forward(rho_i,h_i);
%��������
rhos=rhos+noise.*(-1+2.*rand(size(rhos))).*rhos;
e=1;
LayerNumber=size(rho_i,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   �Ŵ���������


p=0.2;  %����ǰ30%Ϊ��Ӣ�������뽻����죬ֵ�ķ�Χ��0-1֮��
CrossoverProbability=0.6; %�������
MutationProbability=0.5; %�������
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
%     title('Ŀ�꺯���仯����')
    xlabel('Iteration number')
    ylabel('The value of objective function ')
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
% title('�Գ��ļ�װ�õ������Ŵ��㷨һά���ݶԱ�')
xlabel('AB/2(m)')
ylabel('\rho_a/(\Omega��m)')
legend('The curve of Theoretical Model with noise','The curve of Theoretical Model without noise','The curve of GA-Inversional Model',0)
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
xlabel('Depth/m')
ylabel('\rho_a/(\Omega��m)')
% title('�Ŵ��㷨����ģ����ʵ��ģ�ͶԱ�');
legend('Theoretical Model','Inversional Model',0);