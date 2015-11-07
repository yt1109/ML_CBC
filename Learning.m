function [tree] = Learning(examples, attributes, binaryTargets)
   
if range(binaryTargets) == 0 
   % All examples classify as the same
   tree = ClassNode(binaryTargets(1));
elseif isempty(attributes)
   % No more attributes to split on, so choose most popular attribute
   tree = ClassNode(MajorityValue(binaryTargets));
else
   % Get best attribute to split on
   bestAttribute = ChooseBestDecisionAttribute(examples, attributes, binaryTargets);
   disp(bestAttribute);
   bestAttributeIndex = bestAttribute;

   % Split on this attribute
   tree = AttributeNode(bestAttributeIndex);
   for i = 0:1
      examplesI = [];
      bTargetsI = [];
      for j = 1:size(examples,1)
         if examples(j, bestAttributeIndex) == i
            examplesI = [examplesI;examples(j, :)];
            bTargetsI = [bTargetsI;binaryTargets(j)];
         end
      end
       
      if isempty(examplesI)
         % No examples for this branch, so choose most popular attribute
         tree = ClassNode(MajorityValue(binaryTargets));
         return;
      else
         tree.kids{size(tree.kids, 1) + 1} = Learning(examplesI, attributes(attributes~=bestAttribute), bTargetsI);
      end
   end
end
end