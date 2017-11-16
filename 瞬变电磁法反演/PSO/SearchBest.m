function [ optSwarmAll,bestFitnessValue ] = SearchBest( Swarm,FitnessValue )
%寻找粒子群全局最优解及其适値
%   此处显示详细说明
bestFitnessValue=FitnessValue(1);
optSwarmAll=Swarm(1,:);
for i=1:size(Swarm,1)
    if(FitnessValue(i)>bestFitnessValue)
        bestFitnessValue=FitnessValue(i);
        optSwarmAll=Swarm(i,:);
    end
end

end

