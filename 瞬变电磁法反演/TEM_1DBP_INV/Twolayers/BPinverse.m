%%
%·´ÑÝÊý¾Ý
load BPinversemodel_Two.mat
for i=1:size(BPinversemodel,1)
    tic
    rho=BPinversemodel(i,1:2);
    h=BPinversemodel(i,3:end);
    [V,Hz]=TEM1D_forward(rho,h);
    BPinversedata(i,:)=[V];
    toc
    i
end
save BPinversedata_Two BPinversedata