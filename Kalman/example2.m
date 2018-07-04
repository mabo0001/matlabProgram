%Define the length of the simulation.
nlen=20;

%Define the system.
a=1;
h=3;

%Define the noise covariances.
Q=0.01;
R=2;

%Preallocate memory for all arrays.  Note that this is not really necessary
%but speeds up MatLab a bit.
%However, it is necessary to come up with initial estimates (guesses) for
%   1) the state.
%   2) the a priori error.
x=zeros(1,nlen);
z=zeros(1,nlen);
xapriori=zeros(1,nlen);
xaposteriori=zeros(1,nlen);
residual=zeros(1,nlen);
papriori=ones(1,nlen);
paposteriori=ones(1,nlen);
k=zeros(1,nlen);

%Calculate the process and measurement noise.
w1=randn(1,nlen);   %This line and the next can be commented out after running
v1=randn(1,nlen);   %the script once to generate multiple runs with identical
                    %noise (for better comparison).
w=w1*sqrt(Q);
v=v1*sqrt(R);

%Initial condition on the state, x.
x_0=1.0;

%Initial guesses for state and a posteriori covariance.
xaposteriori_0=1.5;
paposteriori_0=1;

%Calculate the first estimates for all values based upon the initial guess
%of the state and the a posteriori covariance.  The rest of the steps will
%be calculated in a loop.
%
%Calculate the state and the output
x(1)=a*x_0+w(1);
z(1)=h*x(1)+v(1);
%Predictor equations
xapriori(1)=a*xaposteriori_0;
residual(1)=z(1)-h*xapriori(1);
papriori(1)=a*a*paposteriori_0+Q;
%Corrector equations
k(1)=h*papriori(1)/(h*h*papriori(1)+R);
paposteriori(1)=papriori(1)*(1-h*k(1));
xaposteriori(1)=xapriori(1)+k(1)*residual(1);

%Calculate the rest of the values.
for j=2:nlen,
    %Calculate the state and the output
    x(j)=a*x(j-1)+w(j);
    z(j)=h*x(j)+v(j);
    %Predictor equations
    xapriori(j)=a*xaposteriori(j-1);
    residual(j)=z(j)-h*xapriori(j);
    papriori(j)=a*a*paposteriori(j-1)+Q;
    %Corrector equations
    k(j)=h*papriori(j)/(h*h*papriori(j)+R);
    paposteriori(j)=papriori(j)*(1-h*k(j));
    xaposteriori(j)=xapriori(j)+k(j)*residual(j);
end

j=1:nlen;

%Plot states and state estimates
subplot(221);
h1=stem(j+0.25,xapriori,'b');
hold on
h2=stem(j+0.5,xaposteriori,'g');
h3=stem(j,x,'r');
hold off
%Make nice formatting.
legend([h1(1) h2(1) h3(1)],'a priori','a posteriori','exact');
title('State with a priori and a posteriori elements');
ylabel('State, x');
xlim=[0 length(j)+1];
set(gca,'XLim',xlim);

%Plot covariance
subplot(222);
h1=stem(j,papriori,'b');
hold on;
h2=stem(j,paposteriori,'g');
hold off
legend([h1(1) h2(1)],'a priori','a posteriori');
title('Calculated a priori and a posteriori covariance');
ylabel('Covariance');
set(gca,'XLim',xlim);  %Set limits the same as first graph

%Plot errors
subplot(223);
h1=stem(j,x-xapriori,'b');
hold on
h2=stem(j,x-xaposteriori,'g');
hold off
legend([h1(1) h2(1)],'a priori','a posteriori');
title('Actual a priori and a posteriori error');
ylabel('Errors');
set(gca,'XLim',xlim);  %Set limits the same as first graph

%Plot kalman gain, k
subplot(224);
h1=stem(j,k,'b');
legend([h1(1)],'kalman gain');
title('Kalman gain');
ylabel('Kalman gain, k');
set(gca,'XLim',xlim);  %Set limits the same as first graph
