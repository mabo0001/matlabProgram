function [lambda,k]=zsxhf_mt1dfy_GUI( handles,lambda_zy,lambda_start,M,kmax ,t_input)
%GUI中用的最速下降法ＭＴ一维反演程序
%   此处显示详细说明
T=logspace(-3,4,100);
w=2*pi./T;
%先正演得到场值
rhos=mt1d(lambda_zy);

%将正演得到的数据进行反演
lambda=lambda_start;%给定初始模型
e=fhi(rhos,lambda);

k=0;%计算迭代次数
while(e(end)>0.1)
    
  if(t_input==-1)
    [p,t]  = pt_zsxjf( rhos,lambda,M );
  else
    p = pt( rhos,lambda );
    t=t_input;
  end
  
  lambda=lambda-p*t;  
  k=k+1;%记录迭代次数
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
    xlabel('迭代次数');
    ylabel('目标函数值');
    title('最速下降法反演目标函数值变化曲线');
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
title('最速下降法反演视电阻率变化图');
legend('观测数据','反演模型正演',0)

end

