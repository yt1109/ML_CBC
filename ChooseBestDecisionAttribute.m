function[bestAttribute] = ChooseBestDecisionAttribute(examples, attributes, binaryTargets)
%returns attribute that maximises information gain

    CurrentAttribute.a = attributes(1);
    CurrentAttribute.iG = -Inf;
    
    %steps through all attritbutes
    for attribute = attributes
        
        p0 = 0;
        n0 = 0;
        p1 = 0;
        n1 = 0;
        
        %steps through each row of each attribute and compare against
        %example outcome
        for i = 1: size(examples, 1)
            
            %value of attribute at example 'i'. value = 1 | 0
            attributeValue = examples(i, attribute);
            
            if binaryTargets(i) == 1
                if attributeValue
                    p1 = p1 + 1;
                else
                    p0 = p0 + 1;
                end
            else
                if attributeValue
                    n1 = n1 + 1;
                else
                    n0 = n0 + 1;
                end
            end
        end
        
        informationGain = InformationGain(p0, n0, p1, n1);
        
        if CurrentAttribute.iG < informationGain
            CurrentAttribute.a = attribute;
            CurrentAttribute.iG = informationGain;
        end
        
    end
    
    bestAttribute = CurrentAttribute.a;
        
end

%helper functions to calculate information gain given the postives and
%negatives compred against the example result
function[informationGain] = InformationGain(p0,  n0, p1, n1)
    informationGain = I(p0 + p1, n0 + n1) - Remainder(p0, n0, p1, n1);
end

function[entropy] = I(p, n)
    pos  = (p / (p + n));
    neg  = (n / (p + n));
    entropy = -pos * log2(pos) - neg * log2(neg);           
end

function[remainder] = Remainder(p0, n0, p1, n1)
    totalExamples = p0 + n0 + p1 + n1;
    remainder = ((p0 + n0) / totalExamples) * I(p0, n0) + ((p1 + n1) / totalExamples) * I(p1, n1);
end