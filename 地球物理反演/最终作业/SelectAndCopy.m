function [ PopulationChild ] = SelectAndCopy( PopulationParent,FitnessValue )
%   ѡ����
%   �˴���ʾ��ϸ˵��
FitnessValueSum=sum(FitnessValue);              %�������и����ʂ��ĺ�
UnitProbability=FitnessValue/FitnessValueSum;   % �������屻ѡ��ĸ���

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       ���̶�ѡ��
for i=1:size(PopulationParent,1)
    FixedPosition=rand;                     %�������0��1֮������������ʾɫ����������Ե��λ��
    RotationPosition=0;                     %���ó�ʼת������λ������Ϊ0
    j=1;                                    %���̵ĳ�ʼѡ��λ��
    while(RotationPosition<FixedPosition)
        RotationPosition=RotationPosition+UnitProbability(j);
        j=j+1;
    end
    PopulationChild(i,:)=PopulationParent(j-1,:);
end


end

