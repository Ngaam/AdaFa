
% This function gives boundaries and dimension of search space for test functions.
function varargout = funcRange(funcIndex)
% Default dimension
dim = 30;

switch funcIndex
    case 1  
        low = -100;     up = 100;
    case 2
        low = -10;      up = 10;
    case 3
        low = -100;     up = 100;
    case 4
        low = -10;      up = 10;
    case 5
        low = -100;     up = 100;
    case 6
        low = -1.28;    up = 1.28;
end

if nargout
    varargout{1} = low;
    varargout{2} = up;
    varargout{3} = dim;
end