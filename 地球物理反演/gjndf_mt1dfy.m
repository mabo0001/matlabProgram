clear
clc
T=logspace(-3,4,100);
w=2*pi./T;
%�����ݵõ���ֵ
rho=[10,200,10];
h=[500,2000];
lambda1=[rho,h];
rhos=mt1d(lambda1);

%�����ݵõ������ݽ��з���
lambda=[5,180,5,411,1800];%������ʼģ��
%�����ʼ��������
% p0=(-1)*pk(rhos,lambda );

%��������
% t=10;
e=fhi( rhos,lambda );

k=0;%�����������
M=0.6;
while(e(end)>0.1)
    
    p=pk_gjndf(  rhos,lambda  ,M)
    t = t_buchang(rhos,lambda,M );
    lambda=lambda+t*p';  

    k=k+1;
    if(k>3000)
        break;
    end
        e(k)=fhi( rhos,lambda ); 
    
  figure(1)
  plot(e);
xlabel('��������');
ylabel('���');
title('�����ݶȷ��������仯����');
end

rhos1=mt1d(lambda);
figure(2)
  semilogx(w,rhos,'-k')
hold on
semilogx(w,rhos1,'-g')
xlabel('Ƶ�ʣ�Hz��');
ylabel('�ӵ����ʣ�ŷķ��');
title('�����ݶȷ������ӵ����ʱ仯ͼ');
legend('�۲�����','������ģ����������',0)