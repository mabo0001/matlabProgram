clear
clc
%%       做一次正演
x=-60:60;
theta=40*pi/180;
z=4;
x0=0;
q=1;
K_LQT=150;
lambda=[x,theta,q,z,x0,K_LQT];
V_LQT= NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );
%%  加噪声
zaosheng=0.2;
V_LQT_withNoise=V_LQT+zaosheng.*(-1+2.*rand(size(V_LQT))).*V_LQT;


%%       开始粒子群优化算法
SwarmSize=80;
Dimensionality=5;
lambda_min=[30*pi/180,0.5,0,-5,100]; 
lambda_max=[50*pi/180,1.5,8,5,150];
Swarm=zeros(SwarmSize,Dimensionality);
vactor=zeros(SwarmSize,Dimensionality);
FitnessValue=zeros(SwarmSize,1);
newFitnessValue=FitnessValue;
v_max=[0.1,0.1,0.1,0.1,0.1];
v_min=-v_max;
w=0.729;%惯性权重
MaxW=0.95;
MinW=0.4;
c1=2;%加速因子
c2=2;
r=1;%约束因子
LoopCount=200;
e=1;

%%       初始化粒子群
    for i=1:SwarmSize
        Swarm(i,:)=lambda_min+(lambda_max-lambda_min).*rand(1,Dimensionality);
        vactor(i,:)=v_min+(v_max-v_min).*rand(1,Dimensionality);
        FitnessValue(i,1)=CalculateFitnessValue( V_LQT_withNoise,x, Swarm(i,:));

    end
%%      把第一个解作为历史最优解    
    optSwarmHistory=Swarm;
%%       寻找适値最大值所对应的粒子,并作为全局最优粒子
[ optSwarmAll,bestFitnessValue ] = SearchBest( Swarm,FitnessValue );

t=0;
tmax=200;
eps=1e-2;
while(e(end)>eps)
    tic
        %速度更新
        for i=1:SwarmSize
%             w=MaxW-t*((MaxW-MinW)/LoopCount);
%             c1=c1_min+(c1_max-c1_min)*t/LoopCount;
%             c2=c2_min+(c2_max-c2_min)*t/LoopCount;
%             vactor(i,:)=w*vactor(i,:)+c1*rand(1,Dimensionality).*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand(1,Dimensionality).*(optSwarmAll-Swarm(i,:));
            vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-Swarm(i,:));
%               vactor(i,:)=w*vactor(i,:)+c1*rand().*(optSwarmHistory(i,:)-Swarm(i,:))+c2*rand().*(optSwarmAll-optSwarmHistory(i,:));
                
         %% 如果速度超过范围，则置为最大值
            for j=1:Dimensionality
                if(vactor(i,j)>v_max(j))
                    vactor(i,j)=v_max(j);
                elseif(vactor(i,j)<v_min(j))
                    vactor(i,j)=v_min(j);
                end
            end

            Swarm(i,:)=Swarm(i,:)+r*vactor(i,:);
            %% 如果粒子超过范围，则置为最大值/重新随机放置
            for j=1:Dimensionality
                if(Swarm(i,j)>lambda_max(j))
                    Swarm(i,j)=lambda_min(j)+(lambda_max(j)-lambda_min(j))*rand();
                elseif(Swarm(i,j)<lambda_min(j))
                    Swarm(i,j)=lambda_min(j)+(lambda_max(j)-lambda_min(j))*rand();
                end
            end

            newFitnessValue(i,1)=CalculateFitnessValue( V_LQT_withNoise,x, Swarm(i,:));
            %% 更新历史最优解
            if(newFitnessValue(i,1)>FitnessValue(i,1))
                FitnessValue(i,1)=newFitnessValue(i,1);
                optSwarmHistory(i,:)=Swarm(i,:);
            end

        end
        %% 更新全局最优解
        [ optSwarmAll,bestFitnessValue ] = SearchBest( optSwarmHistory,FitnessValue );
        t=t+1;
        e(t) = F_target(  V_LQT_withNoise,x,optSwarmAll) ;
        disp(t)
        disp(e(end))
        
        if(t>tmax)
            break;
        end
%     end
toc
end


figure(2)
plot(x,V_LQT_withNoise,'b--','LineWidth',1.5);
hold on
V_LQT_withoutNoise= NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );
plot(x,V_LQT_withoutNoise,'k--','LineWidth',1.5)
V_LQT_PSO=NEF_forward_leiqiuti( x,optSwarmAll(1),optSwarmAll(2),optSwarmAll(3),optSwarmAll(4),optSwarmAll(5) );
plot(x,V_LQT_PSO,'r--','LineWidth',1.5)
% title('广域电磁法的遗传算法一维反演对比')
xlabel('X')
ylabel('V')
legend('The curve of Theoretical Model with noise','The curve of Theoretical Model without noise','The curve of PSO-Inversional Model')

disp(optSwarmAll)