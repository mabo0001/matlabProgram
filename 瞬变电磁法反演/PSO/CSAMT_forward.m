%��CSAMT���ݳ������������ɿ�Դ��ص�Ų��ԭ����Ӧ�á��еĹ�ʽ�����롣�˲�ϵ���õ���Anderson ��801���˲�ϵ����
%�糡����ĶԻ��ֺ˽����˴������Ǽ�ȥ�����һ��Ϊ���Ȱ�ռ�ʱ�Ļ��ֺˣ��Ӷ��ﵽ���ֺ������ٶȼӿ��Ч�������˲�Ч���Ϻã�
%�ų�������öԻ��ֺ˼�ȥ0.5�Ĵ�����������ֱ���編�ļ�������Ч���ܺá�
%������ļ��㷽���������ӻ��١�������̰������飬���й��ڳ�ǿ�ļ��㷽��Ϊ�������������ᡣ
%������Ĺؼ�����ѡ�ú��ʵĺ��˶��˲�ϵ�������˶��˲�ϵ�����ض��������йأ����嶼��һ����Ҫ���ñ��˼���ĺ��˶�ϵ��ʱҪ�˽����������������ޣ�����
%����ȷ���á�
%
%  Based on Walt Anderson's Fortran code, which was published in:
%
%  Anderson, W. L., 1979, Computer Program Numerical Integration of Related
%  Hankel Transforms of Orders 0 and 1 by Adaptive Digital Filtering.
%  Geophysic, 44(7):1287-1305.
%
%�����������Ͽ��Խ������������ݣ�����������Ϊ100��
%���������ˣ�Lidiquan   ����ʱ�䣺2008-10-12
%�����и��ַ��ŵĴ������壺
% R��R������R_xin��R*������rho�������ʣ�phase����λ��k��������Z���迹��h�����d����ȣ�nl������;f:Ƶ��;miu:���ɿռ�ŵ���;epu:��糣��
% RHO�����ݵ����ʣ�wj0��0��hankel�����˲�ϵ����wj1��1��hankel�����˲�ϵ��
%Er_tmp,Efi_tmp,Hr_tmp,Hfi_tmpΪ��ȥ�����һ��Ϊ���Ȱ�ռ�ʱ�ĳ�ֵ
%Er_h,Efi_h,Hr_h,Hfi_hΪ�����һ��Ϊ���Ȱ�ռ�ʱ�ɽ����⹫ʽ����ĳ�ֵ
%Er,Efi,Hr,Hfi,Ex,HyΪһά��״ģ�͵�CSAMT���ݳ�ֵ

%��ʼ��ֵ
%��ʼ��ֵ
function [Ex,Hy,RHO,rho_r,PHASE,ex0,ex2]=CSAMT_forward(rho_i,h_i,x,y,f,PE)

miu=4 * pi * 10^(-7);       %�ŵ���
epu=8.85*10^(-12);          %��糣��
w=2 * pi * f;               %��Ƶ��ϵ��
% PE=PE;

rho=rho_i;
h=h_i;
r = sqrt(x.*x + y.*y);        %�շ���(��)
cos_fi = x ./ r;             %���ռн�����
sin_fi = y ./ r;             %���ռн�����
nl=length(rho) - 1;         %������1

[YBASE,wj0,wj1]=filters_201;
%������ֵ
%������ֵ


%��ʼ��������һ��Ϊ���Ȱ�ռ�ʱ�ĸ�������  �����㹫ʽ�����������飬���д����Ѹ�����
%��ʼ��������һ��Ϊ���Ȱ�ռ�ʱ�ĸ�������
k_h = sqrt( -i .* w .* miu ./ rho(1) + w .* w .* epu .* miu );              %��ͬƵ��ʱ�Ĳ���
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
%������������һ��Ϊ���Ȱ�ռ�ʱ�ĸ�������
%������������һ��Ϊ���Ȱ�ռ�ʱ�ĸ�������


%��ʼ��������R�����͸����������糡���㹫ʽ�����������飬�ų����㹫ʽ�����ӻ��ٺ��̰����飩
%��ʼ��������R�����͸�������
for nf=1:length(f)                                              %Ƶ��ѭ��
    for ii=nl:-1:1;                                             %����ѭ��
         k(nf,ii) = sqrt( -i * w(nf) * miu / rho(ii)  - w(nf) * w(nf) * epu * miu );                  %ÿһ���ڲ�ͬƵ��ʱ�Ĳ���
         k(nf,nl+1) = sqrt( -i * w(nf) * miu / rho(nl+1)  - w(nf) * w(nf) * epu * miu );              %���һ���ڲ�ͬƵ��ʱ�Ĳ��� 
%          k(nf,ii) = sqrt( -i * w(nf) * miu / rho(ii));                  %ÿһ���ڲ�ͬƵ��ʱ�Ĳ���
%          k(nf,nl+1) = sqrt( -i * w(nf) * miu / rho(nl+1));              %���һ���ڲ�ͬƵ��ʱ�Ĳ��� 
       for jj=1:length(wj0);                                  %���ú��ʵ�hankel�˲�ϵ������������Anderson���˲�ϵ����801������һ��Ҫȫ��ѡ�ã�
            R1(nf,nl + 1,jj) = 1;                               %���һ��R����
            R2(nf,nl + 1,jj) = 1;                               %���һ��R*����
            m(jj) = YBASE(jj) / r(1);                              %���շ���r���˲���������й�һ������(����Ҫ)
            u(ii,jj) = sqrt( m(jj)^2 + k(nf,ii)^2 );            %�����ʽ���Ͽ��������⣬����������޸�
            u(ii + 1,jj) = sqrt( m(jj)^2 + k(nf,ii + 1)^2 );    %�����ʽ���Ͽ��������⣬����������޸�
            R2(nf,ii,jj) = coth( u(ii,jj) * h(ii) + acoth( u(ii,jj) / u(ii+1,jj) * R2(nf,ii+1,jj) ) );                           %ÿһ���R*����
            R1(nf,ii,jj) = coth( u(ii,jj) * h(ii) + acoth( u(ii,jj) * rho(ii) / u(ii+1,jj) / rho(ii+1) * R1(nf,ii+1,jj) ) );     %ÿһ���R����
   
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
            
            i10(jj)=F1(jj) * m(jj) * m(jj) * wj1(jj); %����ų��Ĵ�ֱ����
       end
    end
            I4=1/r(1) * sum(i4);
            I5=1/r(1) * sum(i5);
            I6=1/r(1) * sum(i6);
            I7=1/r(1) * sum(i7);
            I8=1/r(1) * sum(i8);
            I9=1/r(1) * sum(i9);
            I10=1/r(1) * sum(i10);
   
        Er_tmp(nf) = PE * cos_fi(1) * i * w(nf) * miu * ( I6 / r(1) + 1 / k(nf,1)^2 * I7 - 1 / k(nf,1)^2  * I8 / r(1)) ;            %��ȥ�����һ��Ϊ���Ȱ�ռ�ʱ�ĳ�ֵ
        Efi_tmp(nf)= PE * sin_fi(1) * ( i * w(nf) * miu * I6 / r(1) - i * w(nf) * miu * I9 + rho(1) * I8 / r(1));    %��ȥ�����һ��Ϊ���Ȱ�ռ�ʱ�ĳ�ֵ
        Hr_tmp(nf) =-PE * sin_fi(1) * (I4 + r(1) * I5) / r(1);                                                               %�ų���ֵ
        Hfi_tmp(nf)= PE * cos_fi(1) * I4 / r(1);                                                                     %�ų���ֵ                             
        
        M=1-3*sin_fi.^2+exp(1i.*sqrt(1i.*w(nf).*miu./rho(1)-w(nf).*w(nf)*miu*epu).*r).*(1-...
          1i.*sqrt(1i.*w(nf).*miu./rho(1)-w(nf).*w(nf)*miu*epu).*r);
        
       Er(nf) =Er_tmp(nf) + Er_h(nf);                          %���ϼ����һ��Ϊ���Ȱ�ռ�ʱ�ĳ�ֵ
        Efi(nf)=Efi_tmp(nf) + Efi_h(nf);                        %���ϼ����һ��Ϊ���Ȱ�ռ�ʱ�ĳ�ֵ
        Hr(nf) =Hr_tmp(nf) - PE / 2 / r(1) / r(1) * sin_fi(1);                                     %�ų���ֵ
        Hfi(nf)=Hfi_tmp(nf) + PE / 2 / r(1) / r(1) * cos_fi(1);                                    %�ų���ֵ  
       ex0(nf)=Er_h(nf)*cos_fi(1) - Efi_h(nf)*sin_fi(1);
       ex2(nf)=Er_tmp(nf)*cos_fi(1) - Efi_tmp(nf)*sin_fi(1);
        Ex(nf) =(Er(nf)*cos_fi(1) - Efi(nf)*sin_fi(1));                 %����Ex
        Ey(nf) =Er(nf)*sin_fi(1) + Efi(nf)*cos_fi(1);                 %����Ex

        Hy(nf) =Hr(nf)*sin_fi(1) + Hfi(nf)*cos_fi(1);                 %����Hy
        Hx(nf) =Hr(nf)*cos_fi(1) - Hfi(nf)*sin_fi(1);                 %����Hy
%         Hy(nf)=Hx(nf)+Hy(nf);
        Hz(nf) = PE * sin_fi(1) * I10 + Hz_h(nf);
        
        Z(nf)  =Ex(nf)/Hy(nf);                                  %�ر�������迹
        RHO(nf)=abs(Z(nf)^2) / w(nf) / miu;                     %���ݵ�����
        rho_r(nf)=Ex(nf)./M./PE.*r.^3;
        PHASE(nf)=-angle(Z(nf)) / pi * 180;                     %������λ
%         Ex(nf)=Ex(nf)+Ey(nf);
end

%Ex=Ex./Ex_h;
%������������R�����͸�������
%������������R�����͸�������