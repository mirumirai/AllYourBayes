function [likelihood,muEst,sigmaEst] = mleGaussian(data,mu,sigma)
% Calculates the maximum likelihood estimate for Gaussian data
% Data can be a scalar or a vector
    if isvector(data)
        likelihood = (1/sqrt(2*pi*sigma^2)) * ...
            exp(-((data-mu).^2)/(2*sigma^2));
        likelihood = prod(likelihood);
        muEst = mean(data);
        sigmaEst = sqrt( sum((data-muEst).^2)/length(data) );
    elseif isscalar(data)
        likelihood = (1/sqrt(2*pi*sigma^2)) * ...
            exp(-((data-mu)^2)/(2*sigma^2));
        muEst = data;
        sigmaEst = 0;
    else
        disp('Data must be scalar or vector!');
    end
end