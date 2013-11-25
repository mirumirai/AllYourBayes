function [choice, params] = makeDecision(data,type,mu,sigma,prior)
% Chooses the more likely of two distributions
% Inputs:
%   data - a scalar or vector of input signals
%	types - Estimation type. Possible types include:
%       'mle' - maximum likelihood estimation
%       'map' - maximum a posteriori estimation
%   mu - 2-element vector, with element 1 corresponding to the mean of the
%       first distribution and element 2 corresponding to the mean of the
%       second distribution
%   sigma - 2-element vector, like mu, except standard deviations
%   prior - 2-element vector, like mu, except prior probabilities
% Returns choice and params
%   choice - either 1 or 2, corresponding to distribution 1 or 2
%   params - 2x2 matrix; first row has estimated mus, second row has 
%           estimated sigmas
% MLE first
if strcmpi(type,'mle')
    [like1,muEst(1),sigmaEst(1)] = mleGaussian(data,mu(1),sigma(1));
    [like2,muEst(2),sigmaEst(2)] = mleGaussian(data,mu(2),sigma(2));
    % Make the decision based on which likelihood is higher
    if like1>like2
        choice = 1;
    elseif like1<like2
        choice = 2;
    else % If they are equal, do a coin flip
        if rand(1)>0.5 
            choice = 1;
        else
            choice = 2;
        end
    end
elseif strcmpi(type,'map')
    [like1,muEst(1),sigmaEst(1)] = mleGaussian(data,mu(1),sigma(1));
    [like2,muEst(2),sigmaEst(2)] = mleGaussian(data,mu(2),sigma(2));
    % Make the decision based on which likelihood*prior is higher
    if like1*prior(1) > like2*prior(2)
        choice = 1;
    elseif like1*prior(1) < like2*prior(2)
        choice = 2;
    else % If they are equal, do a coin flip
        if rand(1)>0.5 
            choice = 1;
        else
            choice = 2;
        end
    end
else
    disp('Estimation type does not exist');
end
params = [muEst;sigmaEst];
end