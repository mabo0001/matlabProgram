function [ lambda,k ] = getdf_DC1DInverse( handles,rhos,rhos_yuanshi,lambda_start,M,kmax ,t_input,LayerNumber )
%对称四极装置一维直流电测深共轭梯度法反演
%   此处显示详细说明
r=logspace(1,4,40);
%将正演得到的数据进行反演
lambda=lambda_start;%给定初始模型
%构造初始搜索方向
p0=(-1)*pk(rhos,lambda,LayerNumber );
%搜索步长
if(t_input==-1)
    H = t_getd( rhos,lambda,M,LayerNumber );
    t=norm(pk(rhos,lambda,LayerNumber))/(p0*H*p0');
else
    t =t_input;
end

e=fhi( rhos,lambda ,LayerNumber);

k=0;%计算迭代次数

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
    xlabel('迭代次数');
    ylabel('目标函数值');
    title('共轭梯度法反演目标函数值变化曲线');
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
ylabel('视电阻率\rho_a/(\Omega·m)')
title('共轭梯度法反演视电阻率变化图');
legend('观测数据','反演模型正演',0)
legend('理论模型正演并加入随机噪声的曲线','理论模型正演曲线','共轭梯度法反演模型正演曲线',0)

end

