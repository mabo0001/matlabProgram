clear
clc
T=logspace(-3,4,100);
w=2*pi./T;
%�����ݵõ���ֵ
rho=[10,200,10];
h=[500,2000];
lambda1=[rho,h];
rhos=mt1d(lambda1);

M=0.07;

%�����ݵõ������ݽ��з���
lambda=[5,200,5,251,1000];%������ʼģ��
%�����ʼ��������
p0=(-1)*pk(rhos,lambda );
%��������
H = t_getd( rhos,lambda,M );
t=norm(pk(rhos,lambda))/(p0*H*p0');

e=fhi( rhos,lambda );
M=0.4;
k=0;%�����������

while(e(end)>0.1)
    
    lambda_k=lambda+t*p0;  
    ak=norm(pk(rhos,lambda_k))/norm(pk(rhos,lambda));    
    
    p0=-pk(rhos,lambda_k)+ak*p0;    
    H = t_getd( rhos,lambda,M );
    t=norm(pk(rhos,lambda))/(p0*H*p0');        
    
    k=k+1;
    if(k>2000)
        break;
    end
  if(e(end)<0.4)  
      if(e(end)>e(end-1))
          break;
      end
  end
    
    lambda=lambda_k;
    
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