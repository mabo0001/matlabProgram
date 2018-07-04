function K=Ke1(aa,bb,t)
a=(t*bb)/(6*aa);
b=(t*aa)/(6*bb);
k11=2*(a+b);
k21=a-2*b;
k31=-a-b;
k41=-2*a+b;
k22=k11;
k32=k41;
k42=k31;
k33=k11;
k43=k21;
k44=k11;
K=[k11 k21 k31 k41;
   k21 k22 k32 k42;
   k31 k32 k33 k43;
   k41 k42 k43 k44];