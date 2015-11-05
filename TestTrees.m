function predictions = TestTrees( T, x2 )
%TESTTREES: returns a vector of predicted labels for each example
%T: array of 6 binary tree structures, which are the trained trees.
%x2: matrix of examples with 45 features
    %1. for each example, use 6 trees to predicte, and choose the majority
    % predicted label.
    %2. 
    predictions = arrayfun(withOneTree(T, X2));
end

function predict = withOneTree ( T, x ) 
 % withOneTree: classify an example with a single trained tree.
 % T: trained tree, a binary sturcture.
 % x: example given, a 45 x 1 vector.
   currentnode = T;
   while ~isempty(currentnode.kids) do
       if x(currentnode.op) == 0
             currentnode = currentnode.kids(0);
       else 
           currentnode = currentnode.kids(1);
       end
   end
   predict = currentnode.class;
end