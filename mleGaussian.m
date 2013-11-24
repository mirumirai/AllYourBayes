function param = mleGaussian(data,mu,sigma)
% Calculates the maximum likelihood estimate for Gaussian data
% Data can be a scalar or a vector
% Mu
    if isvector(x)
        likelihood = (1/sqrt(2*pi*sigma^2)) * ...
            exp(-((x-mu).^2)/(2*sigma^2));
    else
        likelihood = (1/sqrt(2*pi*sigma^2)) * ...
            exp(-((x-mu)^2)/(2*sigma^2));
    end
end