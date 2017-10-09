function [ lambda,k ] = getdf_DC1DInverse( handles,rhos,rhos_yuanshi,lambda_start,M,kmax ,t_input,LayerNumber )
%�Գ��ļ�װ��һάֱ���������ݶȷ�����
%   �˴���ʾ��ϸ˵��
r=logspace(1,4,40);
%�����ݵõ������ݽ��з���
lambda=lambda_start;%������ʼģ��
%�����ʼ��������
p0=(-1)*pk(rhos,lambda,LayerNumber );
%��������
if(t_input==-1)
    H = t_getd( rhos,lambda,M,LayerNumber );
    t=norm(pk(rhos,lambda,LayerNumber))/(p0*H*p0');
else
    t =t_input;
end

e=fhi( rhos,lambda ,LayerNumber);

k=0;%�����������

while(e(end)>0.1)
    
    lambda_k=lambda+t*p0;   
    ak=norm(pk(rhos,lambda_k,LayerNumber))/norm(pk(rhos,lambda,LayerNumber));    
    p0=-pk(rhos,lambda_k,LayerNumber)+ak*p0;
    
    if(t_input==-1)
        H = t_getd( rhos,lambda,M ,LayerNumber);
        t=norm(pk(rhos,lambda,LayerNumber))/(p0*H*p0');
    else
        t =t_input;
    end
    
    k=k+1;
    if(k>kmax)
        break;
    end
    
   if(e(end)<0.4)  
      if(e(end)>e(end-1))
          break;
      end
   end
  
    lambda=lambda_k;   
    e(k)=fhi( rhos,lambda,LayerNumber );   
    axes(handles.axes1);
% figure(1)
    plot(e,'LineWidth',2);
    xlabel('��������');
    ylabel('Ŀ�꺯��ֵ');
    title('�����ݶȷ�����Ŀ�꺯��ֵ�仯����');
end
k=k-1;
rhos1=DC1D_Forward(lambda(1:LayerNumber),lambda(LayerNumber+1:end));
axes(handles.axes2);
% figure(2)

semilogx(r,rhos,'b--*','LineWidth',1.5)
hold on
semilogx(r,rhos_yuanshi,'k--p','LineWidth',1.5)
semilogx(r,rhos1,'r--+','LineWidth',1.5)

xlabel('AB/2(m)')
ylabel('�ӵ�����\rho_a/(\Omega��m)')
title('�����ݶȷ������ӵ����ʱ仯ͼ');
legend('�۲�����','����ģ������',0)
legend('����ģ�����ݲ������������������','����ģ����������','�����ݶȷ�����ģ����������',0)

end

