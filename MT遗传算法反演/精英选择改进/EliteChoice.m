function [ PopulationChild,newFitnessValue,PopulationSave ] = EliteChoice( PopulationParent,FitnessValue,p )
%��Ӣѡ��
%   �˴���ʾ��ϸ˵��


[n,m]=size(PopulationParent);
% %����ÿһ�α����ĺͲ��뽻�����ĸ�����ͬ�����Ա��������ձ�����
PopulationChild=[];
% newFitnessValue=0;
PopulationSave=[];


FitnessValueSum=sum(FitnessValue);              %�������и����ʂ��ĺ�
UnitProbability=FitnessValue/FitnessValueSum;   % �������屻ѡ��ĸ���

UnitProbabilitySort=sort(UnitProbability);
EliteDefinition=UnitProbabilitySort(round(n*(1-p)));                     %����ǰ�ٷ�֮����Ϊ��Ӣ
SaveIndex=1;
ChildIndex=1;

for i=1:n
    if(UnitProbability(i)>EliteDefinition)           %�����i�������ʂ����ʴ���ƽ�����ʣ���洢ΪPopulationSave�������뽻�����
        PopulationSave(SaveIndex,:)=PopulationParent(i,:);
        SaveIndex=SaveIndex+1;
    
    else        %�����i�������ʂ�����С��ƽ�����ʣ���洢ΪPopulationChild���������̶�ѡ�񣬲��뽻�����
        PopulationChild(ChildIndex,:)=PopulationParent(i,:);
        newFitnessValue(ChildIndex)=FitnessValue(i);        
        ChildIndex=ChildIndex+1;
    end
        
end
newFitnessValue=newFitnessValue';

end

