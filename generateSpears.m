function [spears] = generateSpears(prior1,nSpears)
    % Generates nSpears number of spears with priors
    % Note: prior2 = 1-prior1;
    for i = 1:nSpears
        if rand(1)<prior1
            spears(i)=1;
        else
            spears(i)=2;
        end
    end            
end