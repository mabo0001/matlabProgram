%%
%·´ÑÝÊý¾Ý
tic
load BPinversemodel_Three.mat
for i=1:size(BPinversemodel,1)
    tic
    rho=BPinversemodel(i,1:3);
    h=BPinversemodel(i,4:end);
    [V,Hz]=TEM1D_forward(rho,h);
    BPinversedata(i,:)=[V];
    toc
    i
end
save BPinversedata_Three BPinversedata
toc