function [BestIndividual,BestFitnessValue] = CalculateBest( PopulationChild,FitnessValue )
%   ����Ⱥ���е�����ʂ���������Ӧ��ģ��
%   BestIndividual��Ѹ��壬BestFitnessValue����ʂ�
BestIndividual=PopulationChild(1,:);
BestFitnessValue=FitnessValue(1);
for i=2:size(PopulationChild,1)
    if(FitnessValue(i)>BestFitnessValue)
        BestFitnessValue=FitnessValue(i);
        BestIndividual=PopulationChild(i,:);
    end
    
end


end

