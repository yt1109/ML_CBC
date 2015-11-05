function [predictions] = TestTrees( T, x2 )
%TESTTREES: returns a vector of predicted labels for each example
%T: a cell of 6 binary tree structures, which are the trained trees.
%x2: matrix of examples with 45 features
    %1. for each example, use 6 trees to predicte, and choose the majority
    % predicted label.
    %2. 
    predictions = cell(size(x2, 1),1); % predicted labels for all examples
    eachByTrees = cell(size(T,2),1);     % predicted labels for each example
    for i = 1: size(x2, 1)
        for j = 1: size(T, 2)
            eachByTrees(j) = withOneTree(T(j), x2(i,:));
        end
            predictions(i) = mode(eachByTrees);
    end
end

function [predict] = withOneTree ( tree, x ) 
 % withOneTree: classify an example with a single trained tree.
 % T: trained tree, a binary sturcture.
 % x: example given, a 45 x 1 vector.
   currentnode = tree;
   while size(currentnode.kids, 1) ~= 0  
       disp(x);
       if x(currentnode.op) == 0
             currentnode = currentnode.kids{1};
       else 
           currentnode = currentnode.kids{2};
       end
   end
   predict = currentnode.class;
end