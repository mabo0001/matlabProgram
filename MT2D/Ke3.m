function K=Ke3(bb,k,t)
b=(t*k*bb)/6;
k0=[2 1 0 0;
    1 2 0 0;
    0 0 0 0;
    0 0 0 0];
K=b*k0;