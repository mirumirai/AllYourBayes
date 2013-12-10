function [category] = ldaDecision(toCategorize, mu, sigma, prior)
    % LDADECISION Categorizes new data to one of 2 categories
    % Inputs:
    %   mu: 2 element vector of u_1 (category 1) and u_2 (category 2)
    %   sigma: variance of both distributions
    %   prior: 2 element vector of p_1 (for category 1) and p_2 (for cat 2)
    % Output: Category of the data toCategorize (either 1 or 2)
    
    % 1D LDA equation taken from 86-631 Lecture 13 Notes.
    boundary = ((mu(2) + mu(1)) / 2) - ...
        (((sigma^2) / (mu(2) - mu(1))) * log(prior(2) / prior(1)));
    
    if (toCategorize > boundary)
        category = 2;
    % On the boundary -> Choose random category
    elseif (toCategorize == boundary)
        category = round(rand) + 1;
    else
        category = 1;
    end
end