function bostick_GUI( handles,lambda_zy )
%bostick����GUI�õĳ���
%   �˴���ʾ��ϸ˵��

%����
rho=lambda_zy(1:(size(lambda_zy,2)+1)/2);
h=lambda_zy((size(lambda_zy,2)+1)/2+1:end);

[rhos,phase]=MT1D_zhengyan(rho,h);

%����
T=logspace(-3,4,100);
mu=(4e-7)*pi;
H=sqrt(rhos./(2*pi*mu.*(1./T)));%bostick����H
rhoh=rhos.*(180./(2*phase)-1);%bostick����rhos
axes(handles.axes2)

h=stairs(H/1000,rhoh,'LineWidth',2);%����bostick����ģ��
set(h,'color','r')
set(gca,'xscale','log');%����������Ϊ��������
set(gca,'yscale','log');
title('bostick���ݽ��')
xlabel('��ȣ�Km)');
ylabel('������\rho_{s}(\Omega\cdot m)');
grid on

h=diff(H);%bostick���ݵĲ���
[rhos1,phase1]=MT1D_zhengyan(rhoh,h);%��bostick���ݵõ���ģ�ͽ�������
axes(handles.axes1);%ѡ��ڶ�������
semilogx((1./T),rhos,'*');%����ԭʼģ�͵�������Ƶ�ʱ仯����
hold on
semilogx((1./T),rhos1,'r','LineWidth',2);%����bostick����ģ�͵�������Ƶ�ʱ仯����
grid on
title('bostick���ݵ�������Ӧ�Ա�')
xlabel('f(Hz)');
ylabel('\rho_{s}(\Omega\cdotm)')
legend('ԭʼģ����Ӧ','bostick����ģ����Ӧ',0);
set(gca,'xscale','log');

end

