clear
clc

%�����ݵõ���ֵ
% rho_i=[100,10,100];
% h_i=[500,300];
x=0;
y=10000;
load('f_rho_real.mat')
f=f_rho_real(1,:);
% y=4000;
% fmin=-8;
% fmax=13;
% fo=fmin:0.5:fmax;
% f=2.^fo; 
LayerNumber=4;
% rhos = WFEM_forward( rho_i,h_i,x,y );
% %��������
% rhos=rhos+0.1.*(-1+2.*rand(size(rhos))).*rhos;
rhos=f_rho_real(2,:);
e=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   �Ŵ���������
% length=[10,10,10,12,12];
% a=[50,50,400,1500,4500];
% b=[150,220,750,2000,5500];

length=[10,10,10,10,12,12,12];
a=[50,50,400,800,1500,4500,6000];
b=[150,220,750,1500,2000,5500,8000];

p=0.2;  %����ǰ30%Ϊ��Ӣ�������뽻����죬ֵ�ķ�Χ��0-1֮��
CrossoverProbability=0.6; %�������
MutationProbability=1; %�������
PopulationSize=200; %Ⱥ���С

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     �Ŵ��㷨����
PopulationLength=sum(length); %�ַ������ȣ����峤�ȣ�
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %���������ʼȺ��
k=1;
while(e>0.05)
    tic
    TargetFunctionValue  = TargetFunction( rhos,PopulationParent,length,a,b,x,y ,LayerNumber );         %���㸸��Ⱥ��Ŀ�꺯��ֵ
    FitnessValue = CalculateFitnessValue( TargetFunctionValue );                            %���㸸��Ⱥ����ʂ�
    [ PopulationContinue,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p );       %��Ӣѡ��
    PopulationSelect = SelectAndCopy( PopulationContinue,newFitnessValue );              %ѡ����
    PopulationCrossover = Crossover( PopulationSelect,CrossoverProbability );            %����
    PopulationMutate = Mutate( PopulationCrossover,MutationProbability );                %����
    PopulationChild=[PopulationSave;PopulationMutate];                                   %������Ӵ�
    ChildTargetFunctionValue  = TargetFunction( rhos,PopulationChild,length,a,b,x,y,LayerNumber );         %�����Ӵ�Ⱥ���Ŀ�꺯��
    FitnessValue = CalculateFitnessValue( ChildTargetFunctionValue );                   %�����Ӵ�Ⱥ����ʂ�
    [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue );  %��������ʂ���������Ӧ�ĸ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          ������м������

     lambda(k,:)  = DecodeToModel( BestIndividual,length,a,b );
    e(k)=norm(log2(rhos)-log2(WFEM_forward( lambda(k,1:LayerNumber),lambda(k,LayerNumber+1:end),x,y )));
%     figure(1)
%     plot(e,'-*')
% %     title('Ŀ�꺯���仯����')
%     xlabel('Iteration number')
%     ylabel('The value of objective function ')
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
semilogx(f,rhos,'b--','LineWidth',1.5);
hold on
% rhos1=WFEM_forward( rho_i,h_i,x,y );
% semilogx(f,rhos1,'g--','LineWidth',1.5);
index=find(e==min(e));
rhos2=WFEM_forward( lambda(index(1),1:LayerNumber),lambda(index(1),LayerNumber+1:end),x,y );
semilogx(f,rhos2,'r--','LineWidth',1.5)
% title('�����ŷ����Ŵ��㷨һά���ݶԱ�')
xlabel('Frequency/Hz')
ylabel('\rho_a/(\Omega��m)')
legend('The curve of Theoretical Model with noise','The curve of Theoretical Model without noise','The curve of GA-Inversional Model',0)
set(gca,'XDir','reverse')
grid off

% figure(3)
% hhh=cumsum(h_i);
% h=[1,hhh,2*(hhh(end))];
% rho=[rho_i,rho_i(end)];
% stairs(h,rho,'b-*','LineWidth',1.5);
% hold on
% lambda2=cumsum(lambda(index(1),LayerNumber+1:end));
% h1=[1,lambda2,2*(lambda2(end))];
% rho1=[lambda(index(1),1:LayerNumber),lambda(index(1),LayerNumber)];
% stairs(h1,rho1,'r--o','LineWidth',1.5);
% xlabel('Depth/m')
% ylabel('\rho_a/(\Omega��m)')
% % title('�Ŵ��㷨����ģ����ʵ��ģ�ͶԱ�');
% legend('Theoretical Model','Inversional Model',0);
% % set(gca, 'XLim',[0 2*(h1(end))]);set(gca, 'YLim',[0 max(rho1)+5]);