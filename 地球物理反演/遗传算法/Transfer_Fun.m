function T=Transfer_Fun(m)
%电阻率转换函数
global rho
global h
N=size(rho,2);
T=rho(N);
for i=N-1:-1:1;
    A=1-exp(-2*m*h(i));
    B=1+exp(-2*m*h(i));
    T=rho(i)*(rho(i)*A+T*B)/(rho(i)*B+T*A);
end
T=T*m;
end


