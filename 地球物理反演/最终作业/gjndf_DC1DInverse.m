function [  lambda,k ] = gjndf_DC1DInverse(handles,rhos,rhos_yuanshi,lambda_start,M,kmax ,t_input,LayerNumber )
%�Գ��ļ�װ��һάֱ�������Ľ�ţ�ٷ�����
%   �˴���ʾ��ϸ˵��
r=logspace(1,4,40);
%�����ݵõ������ݽ��з���
lambda=lambda_start;%������ʼģ��

e=fhi( rhos,lambda,LayerNumber );

k=0;%�����������

while(e(end)>0.1)
    
    p=pk_gjndf(  rhos,lambda  ,M,LayerNumber);
    
    if(t_input==-1)
        t = t_gjnd(rhos,lambda,M,LayerNumber );
    else
        t=t_input;
    end
    lambda=lambda+t*p';  

    k=k+1;
    if(k>kmax)
        break;
    end
      
      e(k)=fhi( rhos,lambda,LayerNumber );   
      axes(handles.axes1);
% figure(1)
      plot(e,'LineWidth',2);
      xlabel('��������');
      ylabel('Ŀ�꺯��ֵ');
      title('�Ľ�ţ�ٷ�����Ŀ�꺯��ֵ�仯����');
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
title('�Ľ�ţ�ٷ������ӵ����ʱ仯ͼ');
legend('�۲�����','����ģ������',0)
legend('����ģ�����ݲ������������������','����ģ����������','�Ľ�ţ�ٷ�����ģ����������',0)

end

