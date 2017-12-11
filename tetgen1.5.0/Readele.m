 function [eledata,p] = Readele(name)
 
name = [name,'.ele'];

fid = fopen(name,'r');

data = fscanf(fid,'%f ');

fclose(fid);

N = length(data);

n = data(1);

m = (N-3)/n;

data = data(4:end);

data = reshape(data,m,n);

eledata = data';

p = eledata(:,6);

eledata = eledata(:,2:5);


