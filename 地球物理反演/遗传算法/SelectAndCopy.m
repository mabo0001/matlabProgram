function [ PopulationChild ] = SelectAndCopy( PopulationParent,FitnessValue )
%   选择复制
%   此处显示详细说明
FitnessValueSum=sum(FitnessValue);              %计算所有个体适値的和
UnitProbability=FitnessValue/FitnessValueSum;   % 单个个体被选择的概率

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       轮盘赌选择法
for i=1:size(PopulationParent,1)
    FixedPosition=rand;                     %随机产生0，1之间的随机数，表示色字在轮盘外缘的位置
    RotationPosition=0;                     %设置初始转动概率位置坐标为0
    j=1;                                    %轮盘的初始选择位置
    while(RotationPosition<FixedPosition)
        RotationPosition=RotationPosition+UnitProbability(j);
        j=j+1;
    end
    PopulationChild(i,:)=PopulationParent(j-1,:);
end


end

