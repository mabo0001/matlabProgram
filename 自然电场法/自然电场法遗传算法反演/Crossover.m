function [ PopulationChild ] = Crossover( PopulationParent,CrossoverProbability )
%   ����
%   PopulationParentΪ����Ⱥ�壬PopulationChild����֮����Ӵ�Ⱥ�壬CrossoverProbability�������
PopulationChild=ones(size(PopulationParent));%��ʼ�����Ӵ�Ⱥ��ȫ����һ
for i=1:2:size(PopulationParent,1)-1
    if(rand<=CrossoverProbability)       %��������С�ڽ�����ʽ��н���
        CrossoverPoint=round(rand*size(PopulationParent,2));    %������ɽ����
        if(CrossoverPoint<=0)
            CrossoverPoint=1;
        end
        PopulationChild(i,:)=[PopulationParent(i+1,1:CrossoverPoint),PopulationParent(i,CrossoverPoint+1:end)];
        PopulationChild(i+1,:)=[PopulationParent(i,1:CrossoverPoint),PopulationParent(i+1,CrossoverPoint+1:end)];
    else                                %����Ļ��������н���
        PopulationChild(i,:)=PopulationParent(i,:);
        PopulationChild(i+1,:)=PopulationParent(i+1,:);
    end
end


end

