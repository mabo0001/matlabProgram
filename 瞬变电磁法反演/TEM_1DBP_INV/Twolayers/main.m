clc
clear
load model_two.mat
for i=1:size(model,1)
    tic
    rho=model(i,1:2);
    h=model(i,3:end);
    [V,Hz]=TEM1D_forward(rho,h);
    forwarddata(i,:)=[V];
    toc
    i
end
save forwarddata_Two forwarddata
