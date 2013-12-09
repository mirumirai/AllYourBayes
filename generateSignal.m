function signal = generateSignal(spears,type,mu,sigma)
    % GENERATESIGNAL Creates signals for a set of spear locations
    % Type for now has to be 'gaussian' 
    
    % Smiley has rudimentary eyesight, and assumptions (that can be
    % modified by the user) about how his eyesight corresponds to actual
    % spear locations. Each spear generates a perceived location (a 
    % signal). Smiley has to use this signal and his assumptions to make a
    % decision.
    
    % Signal generation distribution parameters mu and sigma are 2x1
    % vectors. Basically determines the "blurriness" of his eyesight.
   
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