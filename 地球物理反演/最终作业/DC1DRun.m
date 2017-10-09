clear
clc
r=logspace(1,4,40);
[rho_s]=DC1D_Forward([10,100,200],[500,300]);

 semilogx(r,rho_s,'-*');
grid on
xlabel('AB/2(m)');
ylabel('\rho_s(\Omega\cdotm)');