function [ PopulationChild ] = Mutate( PopulationParent,MutationProbability )
%变异
%   PopulationParent变异之前的父代群体，PopulationChild变异之后的子代群体，MutationProbability变异概率，
PopulationChild=ones(size(PopulationParent));%为子代群体分配内存
for i=1:size(PopulationParent,1)
    if(rand<MutationProbability)        %如果随机数小于变异概率，则进行变异
        MutationPoint=round(rand*size(PopulationParent,2));  %随机生成变异点
        if(MutationPoint<=0)            %如果变异点小于等于0，则设置为1
            MutationPoint=1;
        end
        PopulationChild(i,:)=PopulationParent(i,:);
        if(PopulationChild(i,MutationPoint)==0)
            PopulationChild(i,MutationPoint)=1;
        else
            PopulationChild(i,MutationPoint)=0;
        end;
    else                            %否则不发生变异
        PopulationChild(i,:)=PopulationParent(i,:);
    end
    
end


end

