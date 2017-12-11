function [nodedata,eledata,facedata,neighdata,p] = Readdata(name)

%name='rec.1';

[nodedata] = Readnode(name);

[eledata,p] = Readele(name);

[facedata] = Readface(name);

[neighdata] = Readneighdata(name);