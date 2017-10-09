function [ PopulationChild,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p )
%精英选择
%   此处显示详细说明


[n,m]=size(PopulationParent);
% %由于每一次保留的和参与交叉变异的个数不同，所以必须进行清空变量；
PopulationChild=[];
% newFitnessValue=0;
PopulationSave=[];


FitnessValueSum=sum(FitnessValue);              %计算所有个体适値的和
UnitProbability=FitnessValue/FitnessValueSum;   % 单个个体被选择的概率

UnitProbabilitySort=sort(UnitProbability);
EliteDefinition=UnitProbabilitySort(round(n*(1-p)));                     %定义前百分之多少为精英
SaveIndex=1;
ChildIndex=1;

for i=1:n
    if(UnitProbability(i)>EliteDefinition)           %如果第i个个体适値概率大于平均概率，则存储为PopulationSave，不参与交叉变异
        PopulationSave(SaveIndex,:)=PopulationParent(i,:);
        SaveIndex=SaveIndex+1;
    
    else        %如果第i个个体适値概率小于平均概率，则存储为PopulationChild，进行轮盘赌选择，参与交叉变异
        PopulationChild(ChildIndex,:)=PopulationParent(i,:);
        newFitnessValue(ChildIndex)=FitnessValue(i);        
        ChildIndex=ChildIndex+1;
    end
        
end
newFitnessValue=newFitnessValue';

end

