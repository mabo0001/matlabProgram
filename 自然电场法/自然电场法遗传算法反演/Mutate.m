function [ PopulationChild ] = Mutate( PopulationParent,MutationProbability )
%����
%   PopulationParent����֮ǰ�ĸ���Ⱥ�壬PopulationChild����֮����Ӵ�Ⱥ�壬MutationProbability������ʣ�
PopulationChild=ones(size(PopulationParent));%Ϊ�Ӵ�Ⱥ������ڴ�
for i=1:size(PopulationParent,1)
    if(rand<MutationProbability)        %��������С�ڱ�����ʣ�����б���
        MutationPoint=round(rand*size(PopulationParent,2));  %������ɱ����
        if(MutationPoint<=0)            %��������С�ڵ���0��������Ϊ1
            MutationPoint=1;
        end
        PopulationChild(i,:)=PopulationParent(i,:);
        if(PopulationChild(i,MutationPoint)==0)
            PopulationChild(i,MutationPoint)=1;
        else
            PopulationChild(i,MutationPoint)=0;
        end;
    else                            %���򲻷�������
        PopulationChild(i,:)=PopulationParent(i,:);
    end
    
end


end

