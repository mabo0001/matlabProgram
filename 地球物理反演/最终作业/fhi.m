function f = fhi( rhos,lambda,LayerNumber )
%�����Է���Ŀ�꺯��
%   rhosΪ�۲����ݣ�lambdaΪģ�Ͳ���
f=norm(log2(rhos)-log2(DC1D_Forward(lambda(1:LayerNumber),lambda(LayerNumber+1:end))));

end

