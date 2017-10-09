%程序为“广域电磁法”的正演，思路按照何继善院士的书《广域电磁法和伪随机信号电法》，实现的结果可以有两种方式，1、Ex；2、Ex/Hy，
%结果会有所区别，但个人认为第二中方式更为合理。
%程序所有人：李帝铨
%编程时间：2010-10-16
function F=CSAMT_halfspace(rho,ii)
global x
global y
global f
global ex
global PE
%本程序用来进行均匀半空间的CSAMT正演,这里用到虚宗量零阶和一阶贝塞尔方程
%采用的公式来自“朴化荣”的《电磁测深法原理》一书。
%程序所有人：Lidiquan   编译时间：2008-5-28
%程序中各种符号的代表意义：
% rho：电阻率；phase：相位；k：波数；Z：阻抗；f:频率;miu:自由空间磁导率;epu:介电常数,RHO：正演电阻率
miu=4 * pi * 10^(-7);       %磁导率
epu=8.85 * 10 ^(-12);       %介电常数
r = sqrt(x.*x + y.*y);        %收发距(米)
cos_fi = x ./ r;            %接收夹角余弦
sin_fi = y ./ r;            %接收夹角正弦
w=2 .* pi .* f(ii);             %角频率系列


%%
%开始计算各个场值
%开始计算各个场值
k=sqrt( -1i .* w .* miu ./ rho - w .* w .* epu .* miu );   %不同频率时的波数
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
%结束计算各个场值
%结束计算各个场值
