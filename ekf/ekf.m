function [x,P]=ekf(fstate,x,P,hmeas,z,Q,R)
    
  L=numel(x);                   %numer of states 状态数
  m=numel(z);                   %numer of measurements 测量次数
  alpha=1e-3;                   %default, tunable  ％默认，可调
  ki=0;                         %default, tunable ％默认，可调
  beta=2;                       %default, tunable  ％默认，可调
  lambda=alpha^2*(L+ki)-L;      %scaling factor 比例因子
  c=L+lambda;                   %scaling factor 比例因子
  Wm=[lambda/c 0.5/c+zeros(1,2*L)]; %weights for means 均值的权重
  Wc=Wm;
  Wc(1)=Wc(1)+(1-alpha^2+beta);     %weights for covariance 协方差的权重
  c=sqrt(c);
  X=sigmas(x,P,c);                  %sigma points around x
  [x1,X1,P1,X2]=ut(fstate,X,Wm,Wc,L,Q); %unscented transformation of process
  [z1,Z1,P2,Z2]=ut(hmeas,X1,Wm,Wc,m,R); %unscented transformation of measurments
  P12=X2*diag(Wc)*Z2';                  %transformed cross-covariance
  K=P12*inv(P2);
  x=x1+K*(z-z1);    %state update
  P=P1-K*P12';      %covariance update
end

function [y,Y,P,Y1]=ut(f,X,Wm,Wc,n,R)
  % Input: f: nonlinear map
  %        X: sigma points
  %        Wm: weights for mean
  %        Wc: weights for covraiance
  %        n: numer of outputs of f
  %        R: additive covariance
  % Output: y: transformed mean
  %         Y: transformed smapling points
  %         P: transformed covariance
  %         Y1: transformed deviations

  L=size(X,2);
  y=zeros(n,1);
  Y=zeros(n,L);
  for k=1:L
      Y(:,k)=f(X(:,k));
      y=y+Wm(k)*Y(:,k);
  end
  Y1=Y-y(:,ones(1,L));
  P=Y1*diag(Wc)*Y1'+R;
end

function X=sigmas(x,P,c)
  %Sigma points around reference point
  %Inputs: x: reference point
  %        P: covariance
  %        c: coefficient
  %Output: X: Sigma points

  A = c*chol(P)';
  Y = x(:,ones(1,numel(x)));
  X = [x Y+A Y-A];
end