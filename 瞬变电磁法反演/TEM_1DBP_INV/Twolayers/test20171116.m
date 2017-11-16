clear
clc
rho=[150,300,100];
h=[150,100];
tic
[V,Hz] = TEM1D_forward(rho,h);
toc
figure(1)
plot(V)
figure(2)
plot(Hz)