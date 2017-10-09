function [ PopulationChild ] = Crossover( PopulationParent,CrossoverProbability )
%   交叉
%   PopulationParent为父代群体，PopulationChild交叉之后的子代群体，CrossoverProbability交叉概率
PopulationChild=ones(size(PopulationParent));%初始化，子代群体全部置一
for i=1:2:size(PopulationParent,1)-1
    if(rand<=CrossoverProbability)       %如果随机数小于交叉概率进行交叉
        CrossoverPoint=round(rand*size(PopulationParent,2));    %随机生成交叉点
        if(CrossoverPoint<=0)
            CrossoverPoint=1;
        end
        PopulationChild(i,:)=[PopulationParent(i+1,1:CrossoverPoint),PopulationParent(i,CrossoverPoint+1:end)];
        PopulationChild(i+1,:)=[PopulationParent(i,1:CrossoverPoint),PopulationParent(i+1,CrossoverPoint+1:end)];
    else                                %否则的话，不进行交叉
        PopulationChild(i,:)=PopulationParent(i,:);
        PopulationChild(i+1,:)=PopulationParent(i+1,:);
    end
end


end

