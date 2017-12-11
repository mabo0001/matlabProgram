function [WTW] = chafen(neighdata,V,point)
Nm = size(neighdata,1);
Tlist = (1:Nm)';
for i = 1:size(neighdata,2)
    Tnei =neighdata(:,i);
    flag = Tnei~=-1;nn = sum(flag);
    if i== 1
        ii = Tlist(flag);jj = Tnei(flag);kk = -1*ones(nn,1);
        ii = [ii ;Tlist(flag)];jj = [jj ;Tlist(flag)] ;kk =[kk ; 1*ones(nn,1)];
    else
        ii = [ii ;Tlist(flag)];jj = [jj ;Tnei(flag)] ;kk =[kk ; -1*ones(nn,1)];
        ii = [ii ;Tlist(flag)];jj = [jj ;Tlist(flag)] ;kk =[kk ; 1*ones(nn,1)];
    end
end
DoT = sparse(ii,jj,kk,Nm,Nm);
wt = ones(Nm,1);
als = 0.0005;
V = spdiags(mkvc(wt), 0,Nm,Nm); 
Wt = spdiags(mkvc(wt),0,Nm,Nm);
WTW = Wt' * ( DoT' * DoT + als * V) * Wt;


      
  
