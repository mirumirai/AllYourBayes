function signal = generateSignal(spears,type,mu,sigma)
    % GENERATESIGNAL Creates signals for a set of spear locations.
    % Inputs:
    %   spears - 1xn vector of spear locations (1 or 2)
    %   type - type of distribution. For now has to be 'gaussian.' Planned
    %       to be extensible for other types of distributions    
    %   mu and sigma - Signal generation distribution parameters mu and
    %       sigma are 2x1 vectors. Basically determines the "blurriness" of
    %       his eyesight.
    % Outputs:
    %   signal - 1xn vector of perceived spear locations (float values)
    
    % Smiley has rudimentary eyesight, and assumptions (that can be
    % modified by the user) about how his eyesight corresponds to actual
    % spear locations. Each spear generates a perceived location (a 
    % signal). Smiley has to use this signal and his assumptions to make a
    % decision.
    
    signal = zeros(1,length(spears));
    
    % Use parameters to create signals
    if strcmpi(type,'gaussian')
        for i=1:length(spears)
            if spears(i) == 1
                signal(i) = normrnd(mu(1),sigma(1));
            else
                signal(i) = normrnd(mu(2),sigma(2));
            end
        end
    end
end