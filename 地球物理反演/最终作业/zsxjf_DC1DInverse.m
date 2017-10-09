function [lambda,k] = zsxjf_DC1DInverse(handles,rhos,rhos_yuanshi,lambda_start,M,kmax ,t_input,LayerNumber )
%对称四极装置一维直流电测深最速下降法反演
%   此处显示详细说明
r=logspace(1,4,40);
%将正演得到的数据进行反演
lambda=lambda_start;%给定初始模型
e=fhi(rhos,lambda,LayerNumber);

k=0;%计算迭代次数
while(e(end)>0.1)
    
  if(t_input==-1)
    [p,t]  = pt_zsxjf( rhos,lambda,M ,LayerNumber );
  else
    p = pt( rhos,lambda,LayerNumber );
    t=t_input;
  end
  
  lambda=lambda-p*t;  
  k=k+1;%记录迭代次数
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
    xlabel('迭代次数');
    ylabel('目标函数值');
    title('最速下降法反演目标函数值变化曲线');
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
ylabel('视电阻率\rho_a/(\Omega·m)')
title('最速下降法反演视电阻率变化图');
legend('观测数据','反演模型正演',0)
legend('理论模型正演并加入随机噪声的曲线','理论模型正演曲线','最速下降法反演模型正演曲线',0)

end

