function [detam] = G_Newton(Wm_Wm,Wd,d_obs,Gij,a,m,W)

H = Gij'*Wd'*Wd*Gij+a*Wm_Wm;

B = Gij'*Wd'*Wd*(d_obs-Gij*m)-a*Wm_Wm*m;

detam = pcg(H,B,10^(-10),100,W);

