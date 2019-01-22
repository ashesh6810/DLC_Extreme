function [E,D]=EOFanalysis(X)

[E,D]=eig(X*X');
D=diag(D);
% figure
% plot(1:50,D(end-[0:49])*100/sum(D),'-o')
% set(gca, 'YScale', 'log')
for n=1:50
    if(sum(D(end-(n-1):end))/sum(D)>=0.85)
        disp(['85%: ' num2str(n)])
        break
    end
end
for n=1:50
    if(sum(D(end-(n-1):end))/sum(D)>=0.9)
        disp(['90%: ' num2str(n)])
        break
    end
end
for n=1:50
    if(sum(D(end-(n-1):end))/sum(D)>=0.95)
        disp(['95%: ' num2str(n)])
        break
    end
end
for n=1:50
    if(sum(D(end-(n-1):end))/sum(D)>=0.99)
        disp(['99%: ' num2str(n)])
        break
    end
end

end
