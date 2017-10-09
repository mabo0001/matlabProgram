function [lambda,k]=zsxhf_mt1dfy_GUI( handles,lambda_zy,lambda_start,M,kmax ,t_input)
%GUI���õ������½����ͣ�һά���ݳ���
%   �˴���ʾ��ϸ˵��
T=logspace(-3,4,100);
w=2*pi./T;
%�����ݵõ���ֵ
rhos=mt1d(lambda_zy);

%�����ݵõ������ݽ��з���
lambda=lambda_start;%������ʼģ��
e=fhi(rhos,lambda);

k=0;%�����������
while(e(end)>0.1)
    
  if(t_input==-1)
    [p,t]  = pt_zsxjf( rhos,lambda,M );
  else
    p = pt( rhos,lambda );
    t=t_input;
  end
  
  lambda=lambda-p*t;  
  k=k+1;%��¼��������
%   e(k+1)=norm(p*t);
e(k+1)=fhi(rhos,lambda);
  if(k>kmax)
      break;
  end
    if(e(end)>e(end-1))
      break;
  end
  axes(handles.axes1);
  plot(e,'LineWidth',2);
  grid on
    xlabel('��������');
    ylabel('Ŀ�꺯��ֵ');
    title('�����½�������Ŀ�꺯��ֵ�仯����');
end
k=k-1;
rhos1=mt1d(lambda);
axes(handles.axes2);
  semilogx(w,rhos,'-k','LineWidth',2)
hold on
semilogx(w,rhos1,'-g','LineWidth',2)
grid on
xlabel('Ƶ�ʣ�Hz��');
ylabel('�ӵ����ʣ�ŷķ��');
title('�����½��������ӵ����ʱ仯ͼ');
legend('�۲�����','����ģ������',0)

end

