%%¡Ω≤„ΩÈ÷ 
clc
clear
for i=1:10
    for j=1:10
        for k=1:10
            model(100*(i-1)+10*(j-1)+k,3)=50*k;
            model(100*(i-1)+10*(j-1)+k,2)=50*j;
            model(100*(i-1)+10*(j-1)+k,1)=50*i;
        end
    end
end
save model_two model