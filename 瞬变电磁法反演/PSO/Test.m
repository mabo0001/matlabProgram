clear
clc
%       ��һ������
lambda=[10,100,500];
LayerNumber=2;
rhos=TEM1D_forward( lambda(1:LayerNumber),lambda(LayerNumber+1:end) );
% �����
rhos=rhos+0.1.*(-1+2.*rand(size(rhos))).*rhos;
%       ��ʼ����Ⱥ�Ż��㷨
SwarmSize=20;
Dimensionality=2*LayerNumber-1;
lambda_min=[0,50,450];
lambda_max=[20,150,550];
Swarm=zeros(SwarmSize,Dimensionality);
vactor=zeros(SwarmSize,Dimensionality);
FitnessValue=zeros(SwarmSize,1);
newFitnessValue=FitnessValue;
% v_min=zeros(1,Dimensionality);
v_max=[0.5,0.5,0.5];
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
LoopCount=200;
e=1;

%       ��ʼ������Ⱥ
    for i=1:SwarmSize
        Swarm(i,:)=lambda_min+(lambda_max-lambda_min).*rand(1,Dimensionality);
        vactor(i,:)=v_min+(v_max-v_min).*rand(1,Dimensionality);
FitnessValue(i,1)=CalculateFitnessValue( rhos,Swarm(i,:),LayerNumber );

    end
%       �ѵ�һ������Ϊ��ʷ���Ž�    
    optSwarmHistory=Swarm;
%       Ѱ���ʂ����ֵ����Ӧ������,����Ϊȫ����������
[ optSwarmAll,bestFitnessValue ] = SearchBest( Swarm,FitnessValue );

t=0;
tmax=200;
eps=1e-2;
while(e(end)>eps)
    tic
%     for t=1:LoopCount
        %�ٶȸ���
        for i=1:SwarmSize
%             w=MaxW-t*((MaxW-MinW)/LoopCount);
%             c1=c1_min+(c1_max-c1_min)*t/LoopCount;
%             c2=c2_min+(c2_max-c2_min)*t/LoopCount;
%             vactor(i,:)=w*vactor(i,:)+c1*rand(1,Dimensionality).*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand(1,Dimensionality).*(optSwarmAll-Swarm(i,:));
            vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-Swarm(i,:));
%               vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-optSwarmHistory(i,:));
                
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
                    Swarm(i,j)=lambda_min(j)+(lambda_max(j)-lambda_min(j))*rand();
                end
            end

newFitnessValue(i,1)=CalculateFitnessValue( rhos,Swarm(i,:),LayerNumber );
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
        e(t) = F_target( rhos,optSwarmAll,LayerNumber );
        disp(t)
        disp(e(end))
        figure(1)
        plot(e)
%         title('Ŀ�꺯���仯����')
        xlabel('Iteration number')
        ylabel('The value of objective function')
        
        if(t>tmax)
            break;
        end
%     end
toc
end


figure(2)
plot(rhos,'b--','LineWidth',1.5);
hold on
rhos1=TEM1D_forward( lambda(1:LayerNumber),lambda(LayerNumber+1:end) );
plot(rhos1,'g--','LineWidth',1.5);
index=find(e==min(e));
rhos2=TEM1D_forward( optSwarmAll(1:LayerNumber),optSwarmAll(LayerNumber+1:end) );
plot(rhos2,'r--','LineWidth',1.5)
% title('�����ŷ����Ŵ��㷨һά���ݶԱ�')
xlabel('Time/s')
ylabel('Voltage/(V)')
legend('The curve of Theoretical Model with noise','The curve of Theoretical Model without noise','The curve of PSO-Inversional Model',0)
% set(gca,'XDir','reverse')
grid off

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
xlabel('Depth/m')
ylabel('\rho_a/(\Omega��m)')
% title('����Ⱥ�Ż��㷨����ģ����ʵ��ģ�ͶԱ�');
legend('Theoretical Model','Inversional Model',0);