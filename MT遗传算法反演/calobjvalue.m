% 2.2.3 ����Ŀ�꺯��ֵ
% calobjvalue.m�����Ĺ�����ʵ��Ŀ�꺯���ļ��㣬�乫ʽ���ñ���ʾ�����棬�ɸ��ݲ�ͬ�Ż����������޸ġ�
%�Ŵ��㷨�ӳ���
%Name: calobjvalue.m
%ʵ��Ŀ�꺯���ļ���
function [objvalue]=calobjvalue(rhos,pop)
% lambda1=pop(:,1:15);
% lambda2=pop(:,16:30);
% lambda3=pop(:,31:45);
% lambda4=pop(:,46:60);
% lambda5=pop(:,61:75);
% 
% temp1=100+decodechrom(lambda1,1,15)*100/(2^15-1); %��popÿ��ת����ʮ������  %����ֵ�� �е���ת��Ϊ������ ����
% temp2=100+decodechrom(lambda2,1,15)*100/(2^15-1); %��popÿ��ת����ʮ������  %����ֵ�� �е���ת��Ϊ������ ����
% temp3=100+decodechrom(lambda3,1,15)*100/(2^15-1); %��popÿ��ת����ʮ������  %����ֵ�� �е���ת��Ϊ������ ����
% temp4=100+decodechrom(lambda4,1,15)*100/(2^15-1); %��popÿ��ת����ʮ������  %����ֵ�� �е���ת��Ϊ������ ����
% temp5=100+decodechrom(lambda5,1,15)*100/(2^15-1); %��popÿ��ת����ʮ������  %����ֵ�� �е���ת��Ϊ������ ����
% 
% lambda=[temp1,temp2,temp3,temp4,temp5];
lambda = DecodeToModel( pop,[15,15,15,15,15] );

for i=1:size(pop,1)
    objvalue(i)=F_target(rhos,lambda(i,:)); %����Ŀ�꺯��ֵ
end
objvalue=objvalue';