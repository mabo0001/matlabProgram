function [ lambda,k ] = getdf_mt1dfy_GUI( handles,lambda_zy,lambda_start,M ,kmax,t_input)
%共轭梯度法MT一维反演GUI中用的程序
%   此处显示详细说明

T=logspace(-3,4,100);
w=2*pi./T;
%先正演得到场值
rhos=mt1d(lambda_zy);

%将正演得到的数据进行反演
lambda=lambda_start;%给定初始模型
%构造初始搜索方向
p0=(-1)*pk(rhos,lambda );
%搜索步长
if(t_input==-1)
    H = t_getd( rhos,lambda,M );
    t=norm(pk(rhos,lambda))/(p0*H*p0');
else
    t =t_input;
end

e=fhi( rhos,lambda );

k=0;%计算迭代次数

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
    xlabel('迭代次数');
    ylabel('目标函数值');
    title('共轭梯度法反演目标函数值变化曲线');
end
k=k-1;
rhos1=mt1d(lambda);
axes(handles.axes2);
  semilogx(w,rhos,'-k','LineWidth',2)
hold on
semilogx(w,rhos1,'-g','LineWidth',2)
grid on
xlabel('频率（Hz）');
ylabel('视电阻率（欧姆）');
title('共轭梯度法反演视电阻率变化图');
legend('观测数据','反演模型正演',0)


end

