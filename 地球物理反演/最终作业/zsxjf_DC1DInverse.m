function [lambda,k] = zsxjf_DC1DInverse(handles,rhos,rhos_yuanshi,lambda_start,M,kmax ,t_input,LayerNumber )
%�Գ��ļ�װ��һάֱ������������½�������
%   �˴���ʾ��ϸ˵��
r=logspace(1,4,40);
%�����ݵõ������ݽ��з���
lambda=lambda_start;%������ʼģ��
e=fhi(rhos,lambda,LayerNumber);

k=0;%�����������
while(e(end)>0.1)
    
  if(t_input==-1)
    [p,t]  = pt_zsxjf( rhos,lambda,M ,LayerNumber );
  else
    p = pt( rhos,lambda,LayerNumber );
    t=t_input;
  end
  
  lambda=lambda-p*t;  
  k=k+1;%��¼��������
%   e(k+1)=norm(p*t);
    e(k+1)=fhi(rhos,lambda,LayerNumber);
  if(k>kmax)
      break;
  end
    if(e(end)>e(end-1))
      break;
  end
  axes(handles.axes1);
%         figure(1)
  plot(e,'LineWidth',2);
    xlabel('��������');
    ylabel('Ŀ�꺯��ֵ');
    title('�����½�������Ŀ�꺯��ֵ�仯����');
end
k=k-1;
rhos1=DC1D_Forward(lambda(1:LayerNumber),lambda(LayerNumber+1:end));
axes(handles.axes2);
%     figure(2)

    
semilogx(r,rhos,'b--*','LineWidth',1.5)
hold on
semilogx(r,rhos_yuanshi,'k--p','LineWidth',1.5)
semilogx(r,rhos1,'r--+','LineWidth',1.5)

xlabel('AB/2(m)')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
title('�����½��������ӵ����ʱ仯ͼ');
legend('�۲�����','����ģ������',0)
legend('����ģ�����ݲ������������������','����ģ����������','�����½�������ģ����������',0)

end

