clear
clc

  %   how to find parameters Q and R using kalman filter by matlab ?     2007-05-28 15:27:47 
%大 中 小 
%标签：科学 
 %我最近在做一个时间序列的状态空间模型,用KALMAN FILTER 及MATLAB, 但最终的参数Q 及R 没法确定,请有关高手指教:
 
%Define the length of the simulation.

n=322; %相当于时间 仿真长度

ss = 13; % state size

os = 1; % observation size

 

%Define the system.

a=[1 1 0 0 0 0 0 0 0 0 0 0 0; 0 1 0 0 0 0 0 0 0 0 0 0 0; 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;...

   0 0 1 0 0 0 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 0 0 0 0 0 0; 0 0 0 0 1 0 0 0 0 0 0 0 0;...

   0 0 0 0 0 1 0 0 0 0 0 0 0; 0 0 0 0 0 0 1 0 0 0 0 0 0; 0 0 0 0 0 0 0 1 0 0 0 0 0;...

   0 0 0 0 0 0 0 0 1 0 0 0 0; 0 0 0 0 0 0 0 0 0 1 0 0 0; 0 0 0 0 0 0 0 0 0 0 1 0 0;...

   0 0 0 0 0 0 0 0 0 0 0 1 0];

 

h = [1 0 1 0 0 0 0 0 0 0 0 0 0];

 

b =[5   3   4.5 7.5 11  14  16.7    18.3    19.2    18.7    16.8    10.8

5.8 3.6 4.9 7.8 11  14.4    16.7    18.2    19.1    18.6    16.6    11.5

6.1 3.8 4.8 7.7 11.2    14.4    16.9    18.1    18.6    18.4    16.5    11.3

4.7 2.9 3.9 7   10  12.9    15.9    17.4    18.2    18.2    15.9    11.6

5.4 3.7 5.1 7.5 11  13.9    16.2    18  18.4    18.1    15.8    11

4.8 2.8 4.4 7.8 11.7    14.4    16.7    18.6    19.1    18.5    16.2    10.8

5   2.9 4.5 7.3 10.9    14.2    16.8    18.3    19  18.7    16.3    11.6

4.4 3   4.7 7.6 10.9    14  16.4    18.2    19.1    18.8    16.6    11.4

4.3 2.4 3.8 7.1 10.8    13.7    16.4    18  19.1    18.1    16.2    11.4

6.2 2.9 4.6 8   11.5    14.4    16.6    18.1    18.9    18.2    16.4    10.5

5.8 3.5 5   7.8 11.1    13.8    16.2    18.2    18.7    18.3    16  11.3

5.2 3.1 5.1 7.7 10.9    14.1    16.8    18.2    19  18.3    16.4    10.7

4.6 2.5 4.2 7.2 10.6    13.6    16.4    17.8    18.7    18.4    16.4    11

4.8 2.9 4.1 7.4 10.4    13.3    16.6    18.2    18.4    18.2    16.3    11.2

5.1 3.1 4.3 7.5 11.1    13.5    16.2    18.2    18.6    18.2    16.1    10.8

5.1 3   4.4 7.5 10.3    13.7    16  18  18.4    18.2    16  10.7

4.9 3   4.2 6.8 11.2    14.2    16.1    17.7    18.3    18  16.1    10.7

5   2.8 4.3 6.8 10.3    13.6    16.3    18.1    18.6    18.6    16.6    12.2

5.2 3.2 4.4 7.4 10.3    13.3    16.3    18  18.6    18  15.8    11

5.6 3.2 4.1 6.9 9.8 13.3    15.8    17.7    18  17.6    15.5    10.1

4.5 2.8 4   7.1 10.9    14  16.1    18  19  18.4    16.4    12.4

5.1 2.7 3.9 7   10.4    13.9    16.8    18.1    18.7    17.7    16.6    11.5

4.9 3   4.3 7.1 10.1    13.4    15.9    17.6    18.8    18.1    16.3    11.4

5.5 3.1 4.8 8.3 11.2    14  16.2    18.1    18.6    18  16  9.9

4.5 2.9 3.7 6.3 10.1    13.9    16.5    18.2    18.9    18.5    16.4    12.2

4.7 2.8 3.5 5.9 9.5 13.2    16.1    18.1    19.1    18.9    16.7    11.1

];           % true observed  data 26*12

 
%对采集到的数进行处理
b=flipud(b); %b上下翻转

b=b'; %转置

b=b(:); %排成列向量

b=b'; %再转置

 

 

%Define the noise covariances.

Q=eye(ss);

%Q(4:end,4:end)=0;

Q=0.86*Q;

R=3.5*eye(os);

 

 

%Calculate the process and measurement noise.

w=randn(13,n);   %This line and the next can be commented out after running

v=randn(1,n);   %the script once to generate multiple runs with identical

                    %noise (for better comparison).

%w=w1*sqrt(Q);

%v=v1*sqrt(R);

 

%Initial condition on the state, x.

x_0=[1 1 16.7 18.9 19.1 18.1 16.1 13.2 9.5 5.9 3.5 2.8  4.7]';

 

initx=x_0;

initV=1;

 

%Initial guesses for state and a posteriori covariance.

xaposteriori_0=[1 1 16.7 18.9 19.1 18.1 16.1 13.2 9.5 5.9 3.5 2.8  4.7]';

paposteriori_0=1;

xaposteriori=1;

paposteriori=1;

 

%Calculate the first estimates for all values based upon the initial guess

%of the state and the a posteriori covariance.  The rest of the steps will

%be calculated in a loop.

%

%Calculate the state and the output 

x=a*x_0 + w(1);   %状态方程

z=h*x + v(1);   %量测方程



 

zR = [];            % true parameters array

xaprioriB = [];     % estimated parameters array

xaposterioriG = []; % measured parameters array

 

%Calculate the rest of the values.

 

Counter = 0;

 

for j=11:n,

    

    Counter = Counter + 1;

   

     %Calculate the state and the output

    x=a*x+w(j);

    z=h*x+v(j);

   

    %Predictor equations

    xapriori=a*xaposteriori;

    residual=z-h*xapriori;

    papriori=a*paposteriori*a'+Q;

   

    %Corrector equations

    k=papriori*h'/(h*papriori*h'+R);

    dd=size(k*h);

    paposteriori=(eye(dd)-k*h)*papriori;

    xaposteriori=xapriori+k*residual;

   

    % Save some parameters in vectors for plotting later

    zR = [zR;z];

    xaprioriB = [xaprioriB;(xapriori(1,:)+xapriori(3,:))];

    xaposterioriG = [xaposterioriG;(xaposteriori(1,:)+xaposteriori(3,:))];

   

end

 

A=a; C=h; y=zR'; xaprioriB=xaprioriB'; xaposterioriG=xaposterioriG';

Max_iter = 5;

%%       做一次正演
x=-156:155;
theta=40*pi/180;
z=4;
x0=0;
q=1;
K_LQT=150;
lambda=[x,theta,q,z,x0,K_LQT];
V_LQT= NEF_forward_leiqiuti( x,theta,q,z,x0,K_LQT );

[xfilt, Vfilt, VVfilt, loglik] = kalman_filter(V_LQT, A, C, Q, R, initx,initV);

plot(x,V_LQT)
hold on 

plot(x,xfilt(1,:))

legend('真实模型正演场值','反演得到的模型正演场值')


xlabel('距离/(m)')
ylabel('电位差/(mV)')
title('类球体模型自然电场法卡尔曼滤波反演对比');
