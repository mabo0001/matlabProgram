clear
clc
T=logspace(-3,4,100);
%先正演得到场值
rho=[100,200,10];
h=[500,2000];
lambda1=[rho,h];
rhos=mt1d(lambda1);
rhos1=rhos;
%将正演得到的数据进行反演
lambda=[90,301,20,700,3000];%给定初始模型
e=fhi(rhos,lambda);

% t=25;
M=1;
k=0;%计算迭代次数
while(e(end)>0.1)
  
  [ p ,t] = pt_zsxjf( rhos,lambda,M);
  lambda=lambda-p*t;  
  k=k+1;%记录迭代次数
%   e(k+1)=norm(p*t);
e(k+1)=fhi(rhos,lambda);
  if(k>2000)
      break;
  end
  if(e(end)>e(end-1))
      break;
  end
  figure(1)
  plot(e);
xlabel('迭代次数');
ylabel('误差');
title('最速下降法反演误差变化曲线');
end
rhos1=mt1d(lambda);
figure(2)
  semilogx(T,rhos,'-k')
hold on
semilogx(T,rhos1,'-g')
xlabel('频率（Hz）');
ylabel('视电阻率（欧姆）');
title('最速下降法反演视电阻率变化图');
legend('观测数据','反演在模型正演数据',0)