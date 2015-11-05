function [tree] = Learning(examples, attributes, binaryTargets)
%
if range(binaryTargets) == 0 
   tree.class = binaryTargets(1);
   tree.kids = cell(0);   
elseif isempty(attributes)
   tree.class = MajorityValue(binaryTargets);
   tree.kids = cell(0);
else
   bestAttribute = ChooseBestDecisionAttribute(examples, attributes, binaryTargets);
   disp(bestAttribute);
   bestAttributeIndex = bestAttribute;

  
    %disp(bestAttributeIndex);
   tree.op = bestAttributeIndex;
   kids = cell(0);
   for i = 0:1
       examplesI = [];
       bTargetsI = [];
       for j = 1:size(examples,1)
           if examples(j,bestAttributeIndex) == i
               examplesI = [examplesI;examples(j, :)];
               bTargetsI = [bTargetsI;binaryTargets(j)];
           end
       end
       if isempty(examplesI)
           tree.class = MajorityValue(binaryTargets);
       else
           kid = Learning(examplesI, attributes(attributes~=bestAttribute), bTargetsI);
           kids{size(kids, 1) + 1} = kid;
       end
   end
   tree.kids = kids;
end
end