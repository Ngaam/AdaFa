% START
function [BestChart,nbest,NumEval] = AdaFa_func(fhd, Dim, Lb, Ub, para)
% MAKE COPIES
   NP = para(1);  
 NGen = para(2);
sigma = para(3);
  rho = para(4);
  Eta = para(5:6);
 fIdx = para(7);
    S = para(8);
% Total number of function evaluations
NumEval = NP*NGen;

% Calcualte dimension
dim = Dim;

% ------------------------------------------------
% generating the initial locations of NP fireflies
[ns, zn] = AdaFa_init(fhd,NP,dim,Lb,Ub,fIdx);
Lightn = zn;

evl = Lightn(1);
BestChart = [];
BestChart = [BestChart; evl]; 

dis = zeros(NP,1);
dis = sum(pdist2(ns,ns));
dis = dis'/(NP-1);


xi = 1;
eta_max = Eta(1);
eta_min = Eta(2);
scale = abs(Ub-Lb);
alfa = 1/dim;
% Iterations or pseudo time marching
for k = 2:NGen     %%%%% start iterations
    % This line of reducing alpha is optional
    alpha = AdaFa_alpha(S,NP,dim,k,NGen);
    
    % Evaluate new solutions (for all n fireflies)
    for i=1:NP
        zn(i)=feval(fhd,ns(i,:),fIdx);
        Lightn(i)=zn(i);
    end
    
    % Ranking fireflies by their light intensity/objectives
    [Lightn,Index] = sort(zn);
    ns_tmp = ns;
    ns = ns_tmp(Index,:);
    
    % Find the current best
    nso = ns; 
    Lighto = Lightn;
    nbest = ns(1,:); 
    Lightbest = Lightn(1);    
  
    if evl>Lightbest
        evl = Lightbest;
    end
  
    dis = sum(pdist2(ns,ns));
    dis = dis'/(NP-1);
    idx = randperm(NP);
    dg = dis(idx(1),1);
    dmax = max(dis);
    dmin = min(dis);      
    
    Dr = (dg-dmin)/(dmax-dmin);
    Ac = 1/(1+sigma*exp(-rho*Dr));
    
    % GRAY THEORY      
    DelTa = abs(repmat(nbest,NP,1)-ns);
    DelTa_max = max(max(DelTa));
    DelTa_min = min(min(DelTa));
    
    rc = (DelTa_min+xi*DelTa_max)*(DelTa+DelTa_max);
    gg = sum(alfa.*rc,2);
    gg_min = min(gg);
    gg_max = max(gg);
    eta = (eta_min-eta_max).*gg/(gg_max-gg_min)...
        +(eta_max*gg_max-eta_min*gg_min)/(gg_max-gg_min);
    % Updating fireflies
for i=1:NP
    for j=1:NP
        r = sqrt(sum((ns(i,:)-ns(j,:)).^2));         
                
        % Update rules              
        if Lightn(i)>Lighto(j) 
            x = rand;
            beta= Dr*exp(-Ac*r.^2);
            tmpf = alpha.*(rand(1,dim)-0.5).*scale;
            if x>=0.5
                ns(i,:) = (1-beta).*ns(i,:)+beta.*nso(j,:)+tmpf;
            else
                ns(i,:) = (1-eta(i))*((NGen-k)/NGen).*nso(i,:)+eta(i).*nbest;
            end
        end        
    end
end

ns = AdaFa_limit(NP,ns,Lb,Ub);
    
    
    BestChart = [BestChart;evl];
end   %%%%% end of iterations
