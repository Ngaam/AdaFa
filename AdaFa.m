clc; clear all; close all
% % ===================================================================== %
% % AdaFa: Adaptive Firefly Algorithm                                     %
% % ===================================================================== %
% %                                                                       %
% % ===================================================================== %
% %     Author:   Ngaam J. Cheung                                         %
% %     Email:    ngaam.ch@gmail.com                                      %
% %     Release:  1.0                                                     %
% %     Release   Date: Sep. 15, 2014.                                    %
% % ===================================================================== %

% % ===================================================================== %
% % NOTE:
% % 1) This source code is freely available to all academic users 
% %     and not-for-profit institutions.
% % 2) Commercial users wishing an evaluation copy should contact the author
% % 3) Commercial users may license the AdaFa software after completing 
% %     the license agreement and sending it to ngaam.ch@gmail.com.
% %
% % If you use AdaFa, please cite the following paper:
% % Ngaam J. Cheung, Xue-Ming Ding, Hong-Bin Shen,
% %   Adaptive Firefly Algorithm: Parameter Analysis and its Application
% % ===================================================================== %
help AdaFa.m

path = pwd;
path = path(1:end-6);

% PARAMETER SETTINGS
 NGen = 1e3;
   NP = 10;
sigma = 1.5;
  rho = 2.5;
  eta = [0.4, 0.05]; 

fcnNam = {'Sphere', 'Schwefel', 'Rosenbrock', 'Rastrigin', 'Ackley', 'Griewank'};

TotRun = 1;
for S = 1:5
    for fIdx = 1:6
        para = [NP, NGen, sigma, rho, eta, fIdx, S];    
        [Lb, Ub, Dim] = funcRange(fIdx);
        
        fprintf('Strategy %d for alpha over ', S);
        fprintf('%s:\n', fcnNam{fIdx});
        for run = 1:TotRun
            rand('seed', sum(10*clock));       
            tic
            [BestChart, U, NumEval] = AdaFa_func('objFunc',Dim,Lb,Ub,para);  
            t = toc;
            
            fprintf('Time = %2.3f,\t',t);
            fprintf('run/TotRun = %d/%d,\t',run, TotRun);
            fprintf('Best-so-far = %.5e\n',BestChart(end));
        end
    end
end







