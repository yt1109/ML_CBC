function [ matrix ] = ConfusionMatrix(classifications, nClasses)
% Given an array of 2-vectors = [actual,classification], calculate the
% confusion matrix of size  nClasses x nClasses 
   matrix = zeros(nClasses);
   
   for i = 1:size(classifications)
      actual = classifications(i, 1);
      predicted = classifications(i, 2);
      
      matrix(actual, predicted) = matrix(actual, predicted) + 1;
   end
end

