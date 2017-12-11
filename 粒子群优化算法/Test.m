clear
clc
%       ��һ������
lambda=[50,200,10,500,300];
rhos=mt1d(lambda);
% �����
rhos=rhos+0.05.*(-1+2.*rand(size(rhos))).*rhos;
%       ��ʼ����Ⱥ�Ż��㷨
SwarmSize=200;
Dimensionality=5;
lambda_min=[0,0,0,300,100];
lambda_max=[200,500,20,700,500];
Swarm=zeros(SwarmSize,Dimensionality);
vactor=zeros(SwarmSize,Dimensionality);
FitnessValue=zeros(SwarmSize,1);
newFitnessValue=FitnessValue;
% v_min=[0,0,0,0,0];
v_max=[0.5,0.5,0.5,0.5,0.5];
v_min=-v_max;
w=0.729;%����Ȩ��
MaxW=0.95;
MinW=0.4;
c1=2;%��������
c2=2;
% c1_min=2;
% c1_max=4;
% c2_min=1;
% c2_max=4;
r=1;%Լ������
LoopCount=1500;
e=1;

%       ��ʼ������Ⱥ
    for i=1:SwarmSize
        Swarm(i,:)=lambda_min+(lambda_max-lambda_min).*rand(1,Dimensionality);
        vactor(i,:)=v_min+(v_max-v_min).*rand(1,Dimensionality);
        FitnessValue(i,1)=CalculateFitnessValue( rhos,Swarm(i,:) );
    end
%       �ѵ�һ������Ϊ��ʷ���Ž�    
    optSwarmHistory=Swarm;
%       Ѱ���ʂ����ֵ����Ӧ������,����Ϊȫ����������
[ optSwarmAll,bestFitnessValue ] = SearchBest( Swarm,FitnessValue );

t=0;
tmax=1500;
eps=1e-4;
while(e(end)>eps)
%     for t=1:LoopCount
        %�ٶȸ���
        for i=1:SwarmSize
    %             w=MaxW-t*((MaxW-MinW)/LoopCount);
    %             c1=c1_min+(c1_max-c1_min)*t/LoopCount;
    %             c2=c2_min+(c2_max-c2_min)*t/LoopCount;
%             vactor(i,:)=w*vactor(i,:)+c1*rand(1,Dimensionality).*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand(1,Dimensionality).*(optSwarmAll-Swarm(i,:));
%                 vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-Swarm(i,:));
                vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-optSwarmHistory(i,:));
                
            %����ٶȳ�����Χ������Ϊ���ֵ
            for j=1:Dimensionality
                if(vactor(i,j)>v_max(j))
                    vactor(i,j)=v_max(j);
                elseif(vactor(i,j)<v_min(j))
                    vactor(i,j)=v_min(j);
                end
            end

            Swarm(i,:)=Swarm(i,:)+r*vactor(i,:);
            %������ӳ�����Χ������Ϊ���ֵ/�����������
            for j=1:Dimensionality
                if(Swarm(i,j)>lambda_max(j))
    %                 Swarm(i,j)=lambda_max(j);
                    Swarm(i,j)=lambda_min(j)+(lambda_max(j)-lambda_min(j))*rand();
                elseif(Swarm(i,j)<lambda_min(j))
    %                 Swarm(i,j)=lambda_min(j);
                    Swarm(i,j)=lambda_min(j)+(lambda_max(j)-lambda_min(j))*rand(1,Dimensionality);
                end
            end

            newFitnessValue(i,1)=CalculateFitnessValue( rhos,Swarm(i,:) );
            %������ʷ���Ž�
            if(newFitnessValue(i,1)>FitnessValue(i,1))
                FitnessValue(i,1)=newFitnessValue(i,1);
                optSwarmHistory(i,:)=Swarm(i,:);
            end
            %����ٶ�ȫ��Ϊ0�������³�ʼ��
    %         if(vactor(i,:)==zeros(1,Dimensionality))
    %             vactor(i,:)=v_min+(v_max-v_min).*rand(1,Dimensionality);
    %         end


        end
        %����ȫ�����Ž�
        [ optSwarmAll,bestFitnessValue ] = SearchBest( optSwarmHistory,FitnessValue );
        t=t+1;

        e(t) = F_target(  rhos,optSwarmAll );
        
        figure(1)
        plot(e)
            title('Ŀ�꺯���仯����')
        xlabel('��������')
        ylabel('Ŀ�꺯��ֵ')
        
        if(t>tmax)
            break;
        end
%     end
end


figure(2)
semilogx(rhos,'b*-','LineWidth',1.5);
hold on

rhos2=mt1d(optSwarmAll);
semilogx(rhos2,'r--','LineWidth',1.5)
title('MT����Ⱥ�Ż��㷨һά���ݶԱ�')
xlabel('ʱ��T/s')
ylabel('�ӵ�����')
legend('ģ��������������','����Ⱥ�Ż��㷨����ģ����������',0)


figure(3)
% ����ģ�ͶԱȽ���ͼ
Index=(Dimensionality+1)/2;
hhh=cumsum(lambda(Index+1:end));
rho_i=lambda(1:Index);
h=[1,hhh,2*(hhh(end))];
rho=[rho_i,rho_i(end)];
stairs(h,rho,'b-*','LineWidth',1.5);
hold on
hh=cumsum(optSwarmAll(Index+1:end));
h1=[1,hh,2*(hh(end))];
rho1=[optSwarmAll(1:Index),optSwarmAll(Index)];
stairs(h1,rho1,'r--o','LineWidth',1.5);
set(gca, 'XLim',[0 2*(hh(end))]);set(gca, 'YLim',[0 max([rho1,rho])+5]);
xlabel('���Depth/m')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
title('����Ⱥ�Ż��㷨����ģ����ʵ��ģ�ͶԱ�');
legend('����ģ��','����ģ��',0);