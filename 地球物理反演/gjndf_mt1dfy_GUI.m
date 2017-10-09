function [  lambda,k ] = gjndf_mt1dfy_GUI(  handles,lambda_zy,lambda_start,M ,kmax,t_input )
%�Ľ�ţ�ٷ�GUI�ó���
%   �˴���ʾ��ϸ˵��
T=logspace(-3,4,100);
w=2*pi./T;
%�����ݵõ���ֵ
rhos=mt1d(lambda_zy);

%�����ݵõ������ݽ��з���
lambda=lambda_start;%������ʼģ��

e=fhi( rhos,lambda );

k=0;%�����������

while(e(end)>0.1)
    
    p=pk_gjndf(  rhos,lambda  ,M);
    
    if(t_input==-1)
        t = t_gjnd(rhos,lambda,M );
    else
        t=t_input;
    end
    lambda=lambda+t*p';  

    k=k+1;
    if(k>kmax)
        break;
    end
      
      e(k)=fhi( rhos,lambda );   
      axes(handles.axes1);
      plot(e,'LineWidth',2);
      grid on
      xlabel('��������');
      ylabel('Ŀ�꺯��ֵ');
      title('�Ľ�ţ�ٷ�����Ŀ�꺯��ֵ�仯����');
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
title('�Ľ�ţ�ٷ������ӵ����ʱ仯ͼ');
legend('�۲�����','����ģ������',0)


end

