function K=Ke2(aa,bb,k)
a=(aa*bb*k)/36;
k0=[4 2 1 1;
    2 4 2 1;
    1 2 4 2;
    1 1 2 4];
K=a*k0;