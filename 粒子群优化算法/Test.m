clear
clc
%       做一次正演
lambda=[50,200,10,500,300];
rhos=mt1d(lambda);
% 加误差
rhos=rhos+0.05.*(-1+2.*rand(size(rhos))).*rhos;
%       开始粒子群优化算法
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
w=0.729;%惯性权重
MaxW=0.95;
MinW=0.4;
c1=2;%加速因子
c2=2;
% c1_min=2;
% c1_max=4;
% c2_min=1;
% c2_max=4;
r=1;%约束因子
LoopCount=1500;
e=1;

%       初始化粒子群
    for i=1:SwarmSize
        Swarm(i,:)=lambda_min+(lambda_max-lambda_min).*rand(1,Dimensionality);
        vactor(i,:)=v_min+(v_max-v_min).*rand(1,Dimensionality);
        FitnessValue(i,1)=CalculateFitnessValue( rhos,Swarm(i,:) );
    end
%       把第一个解作为历史最优解    
    optSwarmHistory=Swarm;
%       寻找适値最大值所对应的粒子,并作为全局最优粒子
[ optSwarmAll,bestFitnessValue ] = SearchBest( Swarm,FitnessValue );

t=0;
tmax=1500;
eps=1e-4;
while(e(end)>eps)
%     for t=1:LoopCount
        %速度更新
        for i=1:SwarmSize
    %             w=MaxW-t*((MaxW-MinW)/LoopCount);
    %             c1=c1_min+(c1_max-c1_min)*t/LoopCount;
    %             c2=c2_min+(c2_max-c2_min)*t/LoopCount;
%             vactor(i,:)=w*vactor(i,:)+c1*rand(1,Dimensionality).*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand(1,Dimensionality).*(optSwarmAll-Swarm(i,:));
%                 vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-Swarm(i,:));
                vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-optSwarmHistory(i,:));
                
            %如果速度超过范围，则置为最大值
            for j=1:Dimensionality
                if(vactor(i,j)>v_max(j))
                    vactor(i,j)=v_max(j);
                elseif(vactor(i,j)<v_min(j))
                    vactor(i,j)=v_min(j);
                end
            end

            Swarm(i,:)=Swarm(i,:)+r*vactor(i,:);
            %如果粒子超过范围，则置为最大值/重新随机放置
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
            %更新历史最优解
            if(newFitnessValue(i,1)>FitnessValue(i,1))
                FitnessValue(i,1)=newFitnessValue(i,1);
                optSwarmHistory(i,:)=Swarm(i,:);
            end
            %如果速度全部为0，则重新初始化
    %         if(vactor(i,:)==zeros(1,Dimensionality))
    %             vactor(i,:)=v_min+(v_max-v_min).*rand(1,Dimensionality);
    %         end


        end
        %更新全局最优解
        [ optSwarmAll,bestFitnessValue ] = SearchBest( optSwarmHistory,FitnessValue );
        t=t+1;

        e(t) = F_target(  rhos,optSwarmAll );
        
        figure(1)
        plot(e)
            title('目标函数变化曲线')
        xlabel('迭代次数')
        ylabel('目标函数值')
        
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
title('MT粒子群优化算法一维反演对比')
xlabel('时间T/s')
ylabel('视电阻率')
legend('模型理论正演曲线','粒子群优化算法反演模型正演曲线',0)


figure(3)
% 绘制模型对比阶梯图
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
xlabel('深度Depth/m')
ylabel('视电阻率\rho_a/(\Omega·m)')
title('粒子群优化算法反演模型与实际模型对比');
legend('理论模型','反演模型',0);