 function [nodedata] = Readnode(name);
 
name = [name,'.node'];

fid = fopen(name,'r');

data = fscanf(fid,'%f ');

fclose(fid);

N = length(data);

n = data(1);

m = (N-4)/n;

data = reshape(data(5:end),m,n);

nodedata = data';

nodedata = nodedata(:,2:4);
