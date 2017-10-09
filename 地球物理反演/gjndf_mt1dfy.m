clear
clc
T=logspace(-3,4,100);
w=2*pi./T;
%先正演得到场值
rho=[10,200,10];
h=[500,2000];
lambda1=[rho,h];
rhos=mt1d(lambda1);

%将正演得到的数据进行反演
lambda=[5,180,5,411,1800];%给定初始模型
%构造初始搜索方向
% p0=(-1)*pk(rhos,lambda );

%搜索步长
% t=10;
e=fhi( rhos,lambda );

k=0;%计算迭代次数
M=0.6;
while(e(end)>0.1)
    
    p=pk_gjndf(  rhos,lambda  ,M)
    t = t_buchang(rhos,lambda,M );
    lambda=lambda+t*p';  

    k=k+1;
    if(k>3000)
        break;
    end
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