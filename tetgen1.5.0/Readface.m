 function [facedata] = Readface(name)
 
name = [name,'.face'];

fid = fopen(name,'r');

data = fscanf(fid,'%f ');

fclose(fid);

N = length(data);

n = data(1);

m = (N-2)/n;

data = data(3:end);

data = reshape(data,m,n);

facedata = data';

facedata = facedata(:,2:4);
