function [ns,Lightn] = AdaFa_init(fhd, n,d,Lb,Ub,funcIndex)
for i=1:n
    ns(i,:) = Lb+(Ub-Lb).*rand(1,d);
    Lightn(i)= feval(fhd,ns(i,:),funcIndex);
end


