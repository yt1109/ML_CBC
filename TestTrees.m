function [predictions] = TestTrees( T, x2 )
%TESTTREES: returns a vector of predicted labels for each example
%T: a cell of 6 binary tree structures, which are the trained trees.
%x2: matrix of examples with 45 features

    predictions = cell(0);
    
    % Classifications for each example
    classifications = cell(size(x2, 1), size(T, 2));
    
    for i = 1: size(x2, 1)
        for j = 1: size(T, 2)
            classifications{i}{j} = getClassification(T{j}, x2(i,:));
        end
    end
    
    % Combine classifications from all emotions to one emotion
    
    % ONE METHOD: Just choose first positive classification
    for i = 1: size(x2, 1)
        for j = 1: size(T, 2)
            if (classifications{i}{j} == 1)
               predictions{i} = emolab2str(j);
            end
        end
    end
end

function [predict] = getClassification(tree, x) 
 % withOneTree: classify an example with a single trained tree.
 % T: trained tree, a binary sturcture.
 % x: example given, a 45 x 1 vector.
   currentnode = tree;
   while size(currentnode.kids, 1) ~= 0  
       if x(currentnode.op) == 0
           currentnode = currentnode.kids{1};
       else
           currentnode = currentnode.kids{2};
       end
   end
   predict = currentnode.class;
end