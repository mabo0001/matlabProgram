% 2.2.3 ����Ŀ�꺯��ֵ
% calobjvalue.m�����Ĺ�����ʵ��Ŀ�꺯���ļ��㣬�乫ʽ���ñ���ʾ�����棬�ɸ��ݲ�ͬ�Ż����������޸ġ�
%�Ŵ��㷨�ӳ���
%Name: calobjvalue.m
%ʵ��Ŀ�꺯���ļ���
function [objvalue]=calobjvalue(pop)
temp1=decodechrom(pop,1,10); %��popÿ��ת����ʮ������
x=temp1*10/1023; %����ֵ�� �е���ת��Ϊ������ ����
objvalue=F_target(x); %����Ŀ�꺯��ֵ