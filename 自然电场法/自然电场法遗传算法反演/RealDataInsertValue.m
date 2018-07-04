clear
clc
load('f_rho_real.mat')
% fmin=-8;
% fmax=7;
% fo=fmin:0.5:fmax;
% f=2.^fo; 
% for i=1:size(f,2)
%     L(i)= LagrangeInsertValue(f_rho_real(1,:),f_rho_real(2,:),f(i));
% end
% loglog(f,L)
loglog(f_rho_real(1,:),f_rho_real(2,:))