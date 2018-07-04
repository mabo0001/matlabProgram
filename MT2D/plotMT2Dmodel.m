function plotMT2Dmodel(X,Z,B,Sp,K)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        颜色定义
%
%    1 1 0; % yellow
%    1 0 1; % magenta 
%    0 1 1; % cyan
%    1 0 0; % red   
%    0 1 0; % green
%    0 0 1; % blue
%    1 1 1; % white
%    0 0 0;% black
fillcolor=jet;             %读取jet颜色色度标准
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if K==0
    K=1;
end
[cc,Nx]=size(X);
[cc,Nz]=size(Z);
pmax=max(B(:));pmin=min(B(:));
k=1;
for m=1:Nx-1
    for n=1:Nz-1
        if(B(n,m)~=0)
            XX(k,:)=[X(m),X(m+1),X(m+1),X(m)];
            ZZ(k,:)=-[Z(n),Z(n),Z(n+1),Z(n+1)];
        %    if(B(n,m)==pmax)
        %        C(k,:)=fillcolor(64,:);
        %    elseif(B(n,m)==pmin)
        %        C(k,:)=fillcolor(1,:);
        %    else
                p(k)=ceil((B(n,m)-1)/K);
                if p(k)==0
                    p(k)=1;
                elseif p(k)==65
                    p(k)=64
                end
                C(k,:)=fillcolor(p(k),:);
        %    end
            k=k+1;
        end
    end
end
[M,N]=size(XX);
for i=1:M                %对每个区块进行颜色填充
    patch(XX(i,:),ZZ(i,:),C(i,:))
    hold on
end
         cb = colorbar('vert');
         yy = get(cb,'ylabel');
    %      rr = get(cb,'YTick')
    %      ee = get(cb,'YTickLabel')
            set(yy,'string','Log10 Resistivity (\Omega m)'); 
    %      set(rr,-pi:pi/2:pi)
    %      set(yy,{'-pi','-pi/2','0','pi/2','pi'})
    %      set(yy,'string',' Resistivity (\Omega m)');
box off
title('模型显示');
xlabel('Horizontal Position(m)');
ylabel('Depth(m)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cSp=size(Sp);
plot(Sp,zeros(cSp)+Z(2)/2,'kv','LineWidth',1,'MarkerEdgeColor','k', 'MarkerFaceColor', 'k','MarkerSize',8)
%axis([X(1) X(Nx) -Z(Nz) -Z(1)+Z(2)/2]);