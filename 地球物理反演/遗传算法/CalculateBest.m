function [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue )
%   计算群体中的最大适値及其所对应的模型
%   BestIndividual最佳个体，BestFitnessValue最佳适値
BestIndividual=PopulationChild(1,:);
BestFitnessValue=FitnessValue(1);
for i=2:size(PopulationChild,1)
    if(FitnessValue(i)>BestFitnessValue)
        BestFitnessValue=FitnessValue(i);
        BestIndividual=PopulationChild(i,:);
    end
    
end


end

