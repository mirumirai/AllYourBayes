function signal = generateSignal(spears,type)
    % GENERATESIGNAL Creates signals for a set of spear locations
    % Type for now has to be 'gaussian' 
    
    % Smiley has rudimentary eyesight, and assumptions (that can be
    % modified by the user) about how his eyesight corresponds to actual
    % spear locations. Each spear generates a perceived location (a 
    % signal). Smiley has to use this signal and his assumptions to make a
    % decision.
    
    % Signal generation distribution parameters. Basically determines the
    % "blurriness" of his eyesight.
    mu1 = 1; sigma1 = 0.5;
    mu2 = 2; sigma2 = 0.5;
   
    signal = zeros(1,length(spears));
    
    % Use parameters to create signals
    if strcmpi(type,'gaussian')
        for i=1:length(spears)
            if spears(i) == 1
                signal(i) = normrnd(mu1,sigma1);
            else
                signal(i) = normrnd(mu2,sigma2);
            end
        end
    end
end