function [ optSwarmAll,bestFitnessValue ] = SearchBest( Swarm,FitnessValue )
%Ѱ������Ⱥȫ�����Ž⼰���ʂ�
%   �˴���ʾ��ϸ˵��
bestFitnessValue=FitnessValue(1);
optSwarmAll=Swarm(1,:);
for i=1:size(Swarm,1)
    if(FitnessValue(i)>bestFitnessValue)
        bestFitnessValue=FitnessValue(i);
        optSwarmAll=Swarm(i,:);
    end
end

end

