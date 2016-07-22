function [ns] = AdaFa_limit(n,ns,Lb,Ub)
nest = ns;
for ii = 1:n
 nest(ii,:) = (nest(ii,:)<Lb).*Lb+(nest(ii,:)>=Lb).*nest(ii,:);
 nest(ii,:) = (nest(ii,:)>Ub).*Ub+(nest(ii,:)<=Ub).*nest(ii,:); 
end