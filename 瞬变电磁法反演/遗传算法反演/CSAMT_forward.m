%本CSAMT正演程序根据汤井田《可控源大地电磁测深法原理及其应用》中的公式而编译。滤波系数用的是Anderson 的801点滤波系数。
%电场计算的对积分核进行了处理，就是减去假设第一层为均匀半空间时的积分核，从而达到积分核收敛速度加快的效果，故滤波效果较好；
%磁场计算采用对积分核减去0.5的处理，在最后加上直流电法的计算结果，效果很好。
%本程序的计算方法借用了朴化荣、汤井田、翁爱华的书，其中关于场强的计算方法为汤井田书中所提。
%本程序的关键在于选用合适的汉克尔滤波系数。汉克尔滤波系数和特定的问题有关，具体都不一样，要借用别人计算的汉克尔系数时要了解其采样间隔和上下限，否则不
%能正确引用。
%
%  Based on Walt Anderson's Fortran code, which was published in:
%
%  Anderson, W. L., 1979, Computer Program Numerical Integration of Related
%  Hankel Transforms of Orders 0 and 1 by Adaptive Digital Filtering.
%  Geophysic, 44(7):1287-1305.
%
%本程序理论上可以进行任意多层正演，这里最大层数为100。
%程序所有人：Lidiquan   编译时间：2008-10-12
%程序中各种符号的代表意义：
% R：R函数；R_xin：R*函数；rho：电阻率；phase：相位；k：波数；Z：阻抗；h：层厚；d：深度；nl：层数;f:频率;miu:自由空间磁导率;epu:介电常数
% RHO：正演电阻率；wj0：0阶hankel积分滤波系数；wj1：1阶hankel积分滤波系数
%Er_tmp,Efi_tmp,Hr_tmp,Hfi_tmp为减去假设第一层为均匀半空间时的场值
%Er_h,Efi_h,Hr_h,Hfi_h为假设第一层为均匀半空间时由解析解公式计算的场值
%Er,Efi,Hr,Hfi,Ex,Hy为一维层状模型的CSAMT正演场值

%开始赋值
%开始赋值
function [Ex,Hy,RHO,rho_r,PHASE,ex0,ex2]=CSAMT_forward(rho_i,h_i,x,y,f,PE)

miu=4 * pi * 10^(-7);       %磁导率
epu=8.85*10^(-12);          %介电常数
w=2 * pi * f;               %角频率系列
% PE=PE;

rho=rho_i;
h=h_i;
r = sqrt(x.*x + y.*y);        %收发距(米)
cos_fi = x ./ r;             %接收夹角余弦
sin_fi = y ./ r;             %接收夹角正弦
nl=length(rho) - 1;         %层数减1

[YBASE,wj0,wj1]=filters_201;
%结束赋值
%结束赋值


%开始计算假设第一层为均匀半空间时的各个场量  （计算公式来自汤井田书，但有错误，已改正）
%开始计算假设第一层为均匀半空间时的各个场量
k_h = sqrt( -i .* w .* miu ./ rho(1) + w .* w .* epu .* miu );              %不同频率时的波数
tmp_h  = i .* k_h .* r;
tmp2_h = besseli(1,tmp_h ./ 2) .* besselk(1,tmp_h ./ 2);                    %I1*K1
tmp3_h = besseli(1,tmp_h ./ 2) .* besselk(0,tmp_h ./ 2) - besseli(0,tmp_h ./ 2) .* besselk(1,tmp_h ./ 2);    %I1*K0-I0*K1
Er_h  = PE .* rho(1) .* cos_fi ./ (r.^3) .* (1 + exp(-tmp_h ./ i) .* (1 + tmp_h ./ i));
Efi_h = PE .* rho(1) .* sin_fi ./ (r.^3) .* (2 - exp(-tmp_h ./ i) .* (1 + tmp_h ./ i));
Ez_h  = PE ./ r .* i .* w .* miu .* cos_fi .* tmp2_h;
Hr_h  = -3 .* PE ./ (r.^2) .* sin_fi .* (tmp2_h + tmp_h ./ 6 .* tmp3_h);
Hfi_h = PE ./ (r.^2) .* cos_fi .* tmp2_h;
Hz_h=PE./r.^4./k_h.^2.*sin_fi .* (3-(3+3.*k_h.*r+k_h.^2.*r.^2).*exp(-k_h.*r));
Ex_h  = Er_h .* cos_fi - Efi_h .* sin_fi;
Hy_h  = Hr_h .* sin_fi + Hfi_h .* cos_fi;
Z_h = Ex_h ./ Hy_h;
%结束计算假设第一层为均匀半空间时的各个场量
%结束计算假设第一层为均匀半空间时的各个场量


%开始计算各层的R函数和各个场量（电场计算公式来自汤井田书，磁场计算公式来自朴化荣和翁爱华书）
%开始计算各层的R函数和各个场量
for nf=1:length(f)                                              %频率循环
    for ii=nl:-1:1;                                             %层数循环
         k(nf,ii) = sqrt( -i * w(nf) * miu / rho(ii)  - w(nf) * w(nf) * epu * miu );                  %每一层在不同频率时的波数
         k(nf,nl+1) = sqrt( -i * w(nf) * miu / rho(nl+1)  - w(nf) * w(nf) * epu * miu );              %最后一层在不同频率时的波数 
%          k(nf,ii) = sqrt( -i * w(nf) * miu / rho(ii));                  %每一层在不同频率时的波数
%          k(nf,nl+1) = sqrt( -i * w(nf) * miu / rho(nl+1));              %最后一层在不同频率时的波数 
       for jj=1:length(wj0);                                  %采用合适的hankel滤波系数个数（由于Anderson的滤波系数有801个，不一定要全部选用）
            R1(nf,nl + 1,jj) = 1;                               %最后一层R函数
            R2(nf,nl + 1,jj) = 1;                               %最后一层R*函数
            m(jj) = YBASE(jj) / r(1);                              %用收发距r对滤波横坐标进行归一化处理(很重要)
            u(ii,jj) = sqrt( m(jj)^2 + k(nf,ii)^2 );            %这个公式书上可能有问题，这里进行了修改
            u(ii + 1,jj) = sqrt( m(jj)^2 + k(nf,ii + 1)^2 );    %这个公式书上可能有问题，这里进行了修改
            R2(nf,ii,jj) = coth( u(ii,jj) * h(ii) + acoth( u(ii,jj) / u(ii+1,jj) * R2(nf,ii+1,jj) ) );                           %每一层的R*函数
            R1(nf,ii,jj) = coth( u(ii,jj) * h(ii) + acoth( u(ii,jj) * rho(ii) / u(ii+1,jj) / rho(ii+1) * R1(nf,ii+1,jj) ) );     %每一层的R函数
   
            F1(jj)=1 / ( m(jj) + u(1,jj) / R2(nf,1,jj) ) - 1 / ( m(jj) + u(1,jj) );
            F2(jj)=( 1 / R1(nf,1,jj) - 1 ) * u(1,jj);
            F3(jj)=u(1,jj) / R2(nf,1,jj) / ( m(jj) + u(1,jj) / R2(nf,1,jj));
            F4(jj)=m(jj) / ( m(jj) + u(1,jj) / R2(nf,1,jj));
  
            i4(jj)=(F4(jj) - 0.5) * wj1(jj);
            i5(jj)=(F3(jj) - 0.5) * m(jj) * wj0(jj);
            i6(jj)=F1(jj) * wj1(jj); 
            i7(jj)=F2(jj) * m(jj) * wj0(jj);
            i8(jj)=F2(jj) * wj1(jj);
            i9(jj)=F1(jj) * m(jj) * wj0(jj);
            
            i10(jj)=F1(jj) * m(jj) * m(jj) * wj1(jj); %计算磁场的垂直分量
       end
    end
            I4=1/r(1) * sum(i4);
            I5=1/r(1) * sum(i5);
            I6=1/r(1) * sum(i6);
            I7=1/r(1) * sum(i7);
            I8=1/r(1) * sum(i8);
            I9=1/r(1) * sum(i9);
            I10=1/r(1) * sum(i10);
   
        Er_tmp(nf) = PE * cos_fi(1) * i * w(nf) * miu * ( I6 / r(1) + 1 / k(nf,1)^2 * I7 - 1 / k(nf,1)^2  * I8 / r(1)) ;            %减去假设第一层为均匀半空间时的场值
        Efi_tmp(nf)= PE * sin_fi(1) * ( i * w(nf) * miu * I6 / r(1) - i * w(nf) * miu * I9 + rho(1) * I8 / r(1));    %减去假设第一层为均匀半空间时的场值
        Hr_tmp(nf) =-PE * sin_fi(1) * (I4 + r(1) * I5) / r(1);                                                               %磁场场值
        Hfi_tmp(nf)= PE * cos_fi(1) * I4 / r(1);                                                                     %磁场场值                             
        
        M=1-3*sin_fi.^2+exp(1i.*sqrt(1i.*w(nf).*miu./rho(1)-w(nf).*w(nf)*miu*epu).*r).*(1-...
          1i.*sqrt(1i.*w(nf).*miu./rho(1)-w(nf).*w(nf)*miu*epu).*r);
        
       Er(nf) =Er_tmp(nf) + Er_h(nf);                          %加上假设第一层为均匀半空间时的场值
        Efi(nf)=Efi_tmp(nf) + Efi_h(nf);                        %加上假设第一层为均匀半空间时的场值
        Hr(nf) =Hr_tmp(nf) - PE / 2 / r(1) / r(1) * sin_fi(1);                                     %磁场场值
        Hfi(nf)=Hfi_tmp(nf) + PE / 2 / r(1) / r(1) * cos_fi(1);                                    %磁场场值  
       ex0(nf)=Er_h(nf)*cos_fi(1) - Efi_h(nf)*sin_fi(1);
       ex2(nf)=Er_tmp(nf)*cos_fi(1) - Efi_tmp(nf)*sin_fi(1);
        Ex(nf) =(Er(nf)*cos_fi(1) - Efi(nf)*sin_fi(1));                 %计算Ex
        Ey(nf) =Er(nf)*sin_fi(1) + Efi(nf)*cos_fi(1);                 %计算Ex

        Hy(nf) =Hr(nf)*sin_fi(1) + Hfi(nf)*cos_fi(1);                 %计算Hy
        Hx(nf) =Hr(nf)*cos_fi(1) - Hfi(nf)*sin_fi(1);                 %计算Hy
%         Hy(nf)=Hx(nf)+Hy(nf);
        Hz(nf) = PE * sin_fi(1) * I10 + Hz_h(nf);
        
        Z(nf)  =Ex(nf)/Hy(nf);                                  %地表测量的阻抗
        RHO(nf)=abs(Z(nf)^2) / w(nf) / miu;                     %正演电阻率
        rho_r(nf)=Ex(nf)./M./PE.*r.^3;
        PHASE(nf)=-angle(Z(nf)) / pi * 180;                     %正演相位
%         Ex(nf)=Ex(nf)+Ey(nf);
end

%Ex=Ex./Ex_h;
%结束计算各层的R函数和各个场量
%结束计算各层的R函数和各个场量