function [ K ] = sk2k( sk ,iw)
% ��������ת��Ϊ����ϵ������
%   
K=zeros(size(sk,1),size(sk,1));
for j=1:size(sk,1)
    for k=iw:-1:1
        if(-iw+j+k>0)
            K(j,-iw+j+k)=sk(j,k);
        end
    end
end

K=K+K';
end

