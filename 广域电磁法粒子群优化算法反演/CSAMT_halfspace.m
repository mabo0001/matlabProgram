%����Ϊ�������ŷ��������ݣ�˼·���պμ���Ժʿ���顶�����ŷ���α����źŵ編����ʵ�ֵĽ�����������ַ�ʽ��1��Ex��2��Ex/Hy��
%������������𣬵�������Ϊ�ڶ��з�ʽ��Ϊ����
%���������ˣ������
%���ʱ�䣺2010-10-16
function F=CSAMT_halfspace(rho,ii)
global x
global y
global f
global ex
global PE
%�������������о��Ȱ�ռ��CSAMT����,�����õ���������׺�һ�ױ���������
%���õĹ�ʽ���ԡ��ӻ��١��ġ���Ų��ԭ��һ�顣
%���������ˣ�Lidiquan   ����ʱ�䣺2008-5-28
%�����и��ַ��ŵĴ������壺
% rho�������ʣ�phase����λ��k��������Z���迹��f:Ƶ��;miu:���ɿռ�ŵ���;epu:��糣��,RHO�����ݵ�����
miu=4 * pi * 10^(-7);       %�ŵ���
epu=8.85 * 10 ^(-12);       %��糣��
r = sqrt(x.*x + y.*y);        %�շ���(��)
cos_fi = x ./ r;            %���ռн�����
sin_fi = y ./ r;            %���ռн�����
w=2 .* pi .* f(ii);             %��Ƶ��ϵ��


%%
%��ʼ���������ֵ
%��ʼ���������ֵ
k=sqrt( -1i .* w .* miu ./ rho - w .* w .* epu .* miu );   %��ͬƵ��ʱ�Ĳ���
tmp = 1i .* k .* r ./ 2;
tmp2 = besseli(1,tmp) .* besselk(1,tmp);
tmp3 = besseli(0,tmp) .* besselk(1,tmp) - besseli(1,tmp) .* besselk(0,tmp);
Ex = PE .* rho ./ (r.^3) .* (3 .* cos_fi.^2 - 2 + ( 1 + k .* r) .* exp(-k .* r));
Ey = PE .* rho ./ (r.^3) .* (3 .* cos_fi.* sin_fi);
% Ex=Ex+Ey;
Hy = PE ./ (r.^2) .* ( (1 - 4 .* sin_fi.^2) .* tmp2 + tmp .* sin_fi.^2 .* tmp3 );
Z = Ex ./ Hy;
% RHO = abs(Z.^2) ./ w ./ miu;
phase = angle(Z) ./ pi .* 180;
F=abs(ex(ii)./1) - abs(Ex);
% F=abs(ex(ii)./hy(ii)) - abs(Ex ./ Hy);
%�������������ֵ
%�������������ֵ
