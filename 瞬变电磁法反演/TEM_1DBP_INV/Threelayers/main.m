clc
clear
tic
load model_three.mat
for i=1:size(model,1)
    tic
    rho=model(i,1:3);
    h=model(i,4:end);
    [V,Hz]=TEM1D_forward(rho,h);
    forwarddata(i,:)=[V];
    toc
    i
end
save forwarddata_Three forwarddata
toc