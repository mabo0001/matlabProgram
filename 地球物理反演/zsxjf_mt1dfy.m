clear
clc
T=logspace(-3,4,100);
%�����ݵõ���ֵ
rho=[100,200,10];
h=[500,2000];
lambda1=[rho,h];
rhos=mt1d(lambda1);
rhos1=rhos;
%�����ݵõ������ݽ��з���
lambda=[90,301,20,700,3000];%������ʼģ��
e=fhi(rhos,lambda);

% t=25;
M=1;
k=0;%�����������
while(e(end)>0.1)
  
  [ p ,t] = pt_zsxjf( rhos,lambda,M);
  lambda=lambda-p*t;  
  k=k+1;%��¼��������
%   e(k+1)=norm(p*t);
e(k+1)=fhi(rhos,lambda);
  if(k>2000)
      break;
  end
  if(e(end)>e(end-1))
      break;
  end
  figure(1)
  plot(e);
xlabel('��������');
ylabel('���');
title('�����½����������仯����');
end
rhos1=mt1d(lambda);
figure(2)
  semilogx(T,rhos,'-k')
hold on
semilogx(T,rhos1,'-g')
xlabel('Ƶ�ʣ�Hz��');
ylabel('�ӵ����ʣ�ŷķ��');
title('�����½��������ӵ����ʱ仯ͼ');
legend('�۲�����','������ģ����������',0)