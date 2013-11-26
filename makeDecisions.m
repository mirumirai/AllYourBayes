% Given an array of data, call the make decision function for each
% element.  Output the resulting array of decisions.
function [decisions, allParams] = makeDecisions(datas, type, mu, sigma, prior)
    decisionAccum = zeros(1,length(datas));
    paramAccum = cell(1,length(datas));
    for i=(1:length(datas))
        [decision, params] = makeDecision(datas(i), type, mu, sigma, prior);
        if decision==1
            decisionAccum(i)=2;
        elseif decision==2
            decisionAccum(i)=1;
        else
            disp('makeDecisions has a bug')
        end
        paramAccum{i} = params;
    end
    decisions = decisionAccum;
    allParams = paramAccum;
end