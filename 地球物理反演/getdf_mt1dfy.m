clear
clc
T=logspace(-3,4,100);
w=2*pi./T;
%先正演得到场值
rho=[10,200,10];
h=[500,2000];
lambda1=[rho,h];
rhos=mt1d(lambda1);

M=0.07;

%将正演得到的数据进行反演
lambda=[5,200,5,251,1000];%给定初始模型
%构造初始搜索方向
p0=(-1)*pk(rhos,lambda );
%搜索步长
H = t_getd( rhos,lambda,M );
t=norm(pk(rhos,lambda))/(p0*H*p0');

e=fhi( rhos,lambda );
M=0.4;
k=0;%计算迭代次数

while(e(end)>0.1)
    
    lambda_k=lambda+t*p0;  
    ak=norm(pk(rhos,lambda_k))/norm(pk(rhos,lambda));    
    
    p0=-pk(rhos,lambda_k)+ak*p0;    
    H = t_getd( rhos,lambda,M );
    t=norm(pk(rhos,lambda))/(p0*H*p0');        
    
    k=k+1;
    if(k>2000)
        break;
    end
  if(e(end)<0.4)  
      if(e(end)>e(end-1))
          break;
      end
  end
    
    lambda=lambda_k;
    
    e(k)=fhi( rhos,lambda );
    
  figure(1)
  plot(e);
xlabel('迭代次数');
ylabel('误差');
title('共轭梯度法反演误差变化曲线');
end

rhos1=mt1d(lambda);
figure(2)
  semilogx(w,rhos,'-k')
hold on
semilogx(w,rhos1,'-g')
xlabel('频率（Hz）');
ylabel('视电阻率（欧姆）');
title('共轭梯度法反演视电阻率变化图');
legend('观测数据','反演在模型正演数据',0)