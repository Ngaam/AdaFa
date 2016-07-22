function alpha = AdaFa_alpha(S,NP,dim,k,NGen)
strategy = S;
switch strategy
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IMPROVED STRATEGY FOR ALPHA
    % NEED DEFINE DELTA 
    case 1     % % strategy 1
        delta = 8;
        Delta = (exp(delta)/eps)*((NGen-k)/k);
        alpha = Delta^(-exp(((k-NGen)/k)));
        
    case 2     % % strategy 2
        delta = 80;
        Delta = (exp(delta))^power((NGen-k)/NGen,1/k);
        alpha = Delta^(-exp(-(NGen-k)/k));
        
    case 3     % % strategy 3
        delta = 700;
        Delta = (exp(delta)/(k^(power(NP/dim,1))))^((NGen-k)/NGen);
        alpha = Delta^(-exp(((k-NGen)/k)));
        
        % CONSTANT DELTA
    case 4     % % strategy 4
        Delta = (k^(power(NP,0.75)))*((NGen-k)/k);
        alpha = Delta^(-exp(((k-NGen)/k))); 
        
    case 5     % % strategy 5
        Delta = (1/(k^(power(NP+dim,1))))^((NGen-k)/NGen); 
        alpha = Delta^exp(((k-NGen)/k));
        alpha = alpha*(NGen-k)/NGen;
end
        














