
%
% This function calculates the value of the objective function.
function fit = objFunc(L, F_index)
%Insert your own objective function with a new F_index.
dim = length(L);
if F_index==1
    fit=sum(L.^2);
end

if F_index==2 
    fit=sum(abs(L.^2))+prod(abs(L));
end

if F_index==3
    fit=0;
    for i=1:dim
        fit=fit+sum(L(1:i))^2;
    end
end

if F_index==4
    fit=sum(100*(L(2:dim)-(L(1:dim-1).^2)).^2+(L(1:dim-1)-1).^2);
end

if F_index==5
    fit=sum(floor((L+.5)).^2);
end

if F_index==6
    fit=sum([1:dim].*(L.^4))+rand;
end


