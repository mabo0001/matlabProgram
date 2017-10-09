function  GA_Inversion( handles,lambda_GAzy,noise,length,min,max,factor,jiaocha,bianyi,qtSize,kmax,LayerNumber )
%   DC1D �Ŵ��㷨���ݳ���
%   �˴���ʾ��ϸ˵��
%�����ݵõ���ֵ

r=logspace(1,4,40);
rhos=DC1D_Forward(lambda_GAzy(1:LayerNumber),lambda_GAzy(LayerNumber+1:end));
%��������
rhos=rhos+noise.*(-1+2.*rand(size(rhos))).*rhos;
e=1;
% LayerNumber=3;
% e=0.1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   �Ŵ���������
% length=[10,10,10,12,12];
a=min;
b=max;

p=factor;  %����ǰ30%Ϊ��Ӣ�������뽻����죬ֵ�ķ�Χ��0-1֮��
CrossoverProbability=jiaocha; %�������
MutationProbability=bianyi; %�������
PopulationSize=qtSize; %Ⱥ���С

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     �Ŵ��㷨����
PopulationLength=sum(length); %�ַ������ȣ����峤�ȣ�
PopulationParent= StartPopulation( PopulationSize,PopulationLength ); %���������ʼȺ��
k=1;
while(e>0.01)
%     tic
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
          axes(handles.axes1);
    plot(e,'-*')
    title('Ŀ�꺯���仯����')
    xlabel('��������')
    ylabel('Ŀ�꺯��ֵ')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        ������һ�ε���
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
title('�Գ��ļ�װ�õ������Ŵ��㷨һά���ݶԱ�')
xlabel('AB/2(m)')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
legend('����ģ�����ݲ������������������','����ģ����������','�Ŵ��㷨����ģ����������',0)
grid off

      axes(handles.axes3);
% ����ģ�ͶԱȽ���ͼ
hhh=cumsum(lambda_GAzy(LayerNumber+1:end));
h=[1,hhh,2*(hhh(end))];
rho=[lambda_GAzy(1:LayerNumber),lambda_GAzy(LayerNumber)];
stairs(h,rho,'b-*','LineWidth',1.5);
hold on
lambda2=cumsum(lambda(end,LayerNumber+1:end));
h1=[1,lambda2,2*(lambda2(end))];
rho1=[lambda(end,1:LayerNumber),lambda(end,LayerNumber)];
stairs(h1,rho1,'r--o','LineWidth',1.5);
xlabel('���Depth/m')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
title('�Ŵ��㷨����ģ����ʵ��ģ�ͶԱ�');
legend('����ģ��','����ģ��',0);
% set(gca, 'XLim',[0 2*(h1(end))]);set(gca, 'YLim',[0 max(rho1)+5]);

end

