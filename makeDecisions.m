% Given an array of data, call the make decision function for each
% element.  Output the resulting array of decisions.
function [decisions] = makeDecisions(datas, type, mu, sigma, prior)
    decisionAccum = zeros(1,length(datas));
    for i=(1:length(datas))
       decisionAccum(i) = makeDecision(datas(i), type, mu, sigma, prior);
    end
    decision = decisionAccum;
end