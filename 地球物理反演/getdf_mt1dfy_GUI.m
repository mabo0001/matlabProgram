function [ lambda,k ] = getdf_mt1dfy_GUI( handles,lambda_zy,lambda_start,M ,kmax,t_input)
%�����ݶȷ�MTһά����GUI���õĳ���
%   �˴���ʾ��ϸ˵��

T=logspace(-3,4,100);
w=2*pi./T;
%�����ݵõ���ֵ
rhos=mt1d(lambda_zy);

%�����ݵõ������ݽ��з���
lambda=lambda_start;%������ʼģ��
%�����ʼ��������
p0=(-1)*pk(rhos,lambda );
%��������
if(t_input==-1)
    H = t_getd( rhos,lambda,M );
    t=norm(pk(rhos,lambda))/(p0*H*p0');
else
    t =t_input;
end

e=fhi( rhos,lambda );

k=0;%�����������

while(e(end)>0.1)
    
    lambda_k=lambda+t*p0;   
    ak=norm(pk(rhos,lambda_k))/norm(pk(rhos,lambda));    
    p0=-pk(rhos,lambda_k)+ak*p0;
    
    if(t_input==-1)
        H = t_getd( rhos,lambda,M );
        t=norm(pk(rhos,lambda))/(p0*H*p0');
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
    e(k)=fhi( rhos,lambda );   
    axes(handles.axes1);
    plot(e,'LineWidth',2);
    grid on
    xlabel('��������');
    ylabel('Ŀ�꺯��ֵ');
    title('�����ݶȷ�����Ŀ�꺯��ֵ�仯����');
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
title('�����ݶȷ������ӵ����ʱ仯ͼ');
legend('�۲�����','����ģ������',0)


end

