function [tree] = Learning(examples, attributes, binaryTargets)
%DecisionTreeLearning Trains a decision tree using given examples

if range(binaryTargets) == 0 
   tree.class = binaryFeatures(1);
   tree.kids = cell(0);   
elseif size(attributes) == 0
   tree.class = MajorityValue(binaryTargets);
   tree.kids = cell(0);
else
   bestAttribute = ChooseBestDecisionAttribute(examples, attributes, binaryTargets);
   tree.op = emolab2str(bestAttribute);
   for i = 0:1
       examplesI = [];
       bTargetsI = [];
       for j = 1:size(examples,1)
           if examples(j,bestAttribute) == i
               examplesI = [examplesI;examples(j, :)];
               bTargetsI = [bTargetsI;binaryTargets(j)];
           end
       end
       if isempty(examplesI)
           tree.class = MajorityValue(binaryTargets);
           tree.kids = cell(0);
       else
           tree.kids{i} = Learning(examplesI, attributes(attributes~=bestAttribute), bTargetsI);
       end
   end
end