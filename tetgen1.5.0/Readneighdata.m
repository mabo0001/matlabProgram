 function [neighdata] = Readneighdata(name);
 
name = [name,'.neigh'];

fid = fopen(name,'r');

data = fscanf(fid,'%f ');

fclose(fid);

N = length(data);

n = data(1);

m = (N-2)/n;

data = reshape(data(3:end),m,n);

neighdata = data';

neighdata = neighdata(:,2:5);