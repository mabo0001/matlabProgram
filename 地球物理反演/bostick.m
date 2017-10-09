function [H,rhoh]= bostick( rhos, phase)
% bostick����
%   �˴���ʾ��ϸ˵��
T=logspace(-3,4,40);
mu=(4e-7)*pi;
H=sqrt(rhos./(2*pi*mu.*(1./T)));%bostick����H
rhoh=rhos.*(180./(2*phase)-1);%bostick����rhos
h=stairs(H/1000,rhoh);%����bostick����ģ��
set(h,'color','r')
set(gca,'xscale','log');%����������Ϊ��������
set(gca,'yscale','log');
title('bostick���ݽ��')
xlabel('��ȣ�Km)');
ylabel('������\rho_{s}(\Omega\cdot m)');
h=diff(H);%bostick���ݵĲ���
[rhos1,phase1]=MT1D_zhengyan(rhoh,h);%��bostick���ݵõ���ģ�ͽ�������
figure(2);%ѡ��ڶ�������
semilogx((1./T),rhos,'*');%����ԭʼģ�͵�������Ƶ�ʱ仯����
hold on
semilogx((1./T),rhos1,'r');%����bostick����ģ�͵�������Ƶ�ʱ仯����
title('bostick���ݵ�������Ӧ�Ա�')
xlabel('f(Hz)');
ylabel('\rho_{s}(\Omega\cdotm)')
legend('ԭʼģ����Ӧ','����ģ����Ӧ',0);
set(gca,'xscale','log');



end

