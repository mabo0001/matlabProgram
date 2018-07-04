function [ nsumr ] = noise_bzt( L )
%  板状体加噪声正演
%   
%% 板状体模型，修改模型就修改这些的
I=1;
rho=1000;
alpha=35*pi/180;
x0=0;
nois=0.3;
% nois=0.;
z=10;

%% 正演
K_BZT=I*rho/(2*pi);

B=L*cos(alpha);
C=L*sin(alpha);

k=1;
nsumr=0;
for x=-60:60
    
    A=(x-x0);
    D=((A-B).^2+(z-C).^2)./((A+B).^2+(z+C).^2);
    V(k)=K_BZT.*log(D);
    V(k)=V(k)*(1.0+nois*(randn-0.5)); 
    cre(k)=1./power(1.1,abs(x));
    nsumr=nsumr+V(k)*cre(k);
end


nsumr=nsumr/1000. ;   % adjust amplitude/range 调整幅度/范围



end

