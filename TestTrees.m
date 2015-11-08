function [predictions] = TestTrees( T, x2 )
%TESTTREES: returns a vector of predicted labels for each example
%T: a cell of 6 binary tree structures, which are the trained trees.
%x2: matrix of examples with 45 features

    predictions = double(1004);
    %predictions = zeros(0);
    
    % Get classifications for each example using tree
    classifications = cell(size(x2, 1), size(T, 2));
    
    for i = 1: size(x2, 1)
        for j = 1: size(T, 2)
            classifications{i}{j} = getClassification(T{j}, x2(i,:));
        end
    end
    
    % Choose classification to use
    for i = 1: size(x2, 1)
        currentClassification = classifications{i}{1};
        currentClassificationIndex = 1;
        for j = 1: size(T, 2)
            if (currentClassification.class == 1)
               % If we have a positive classification, replace it if we
               % find a stronger positive classification
               if (classifications{i}{j}.class == 1 && currentClassification.strength < classifications{i}{j}.strength)
                  currentClassification = classifications{i}{j}
                  currentClassificationIndex = j;
               end
            else
               % If we have a negitive classification, replace it if we find a 
               % positive classification or a weaker negative classification
               if (classifications{i}{j}.class == 1 || ...
                  (classifications{i}{j}.class == 0 && classifications{i}{j}.strength < currentClassification.strength))
                  currentClassification = classifications{i}{j};
                  currentClassificationIndex = j;
               end
            end
        end
        predictions(i, 1) = currentClassificationIndex;
        %predictions{i} = emolab2str(currentClassificationIndex);
    end
end

function [predict] = getClassification(tree, x) 
 % getClassification: classify an example with a single trained tree.
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
   % Penalise those nodes which are far down within the tree
   predict = Classification(currentnode.class, -currentnode.level);
end

function [classification] = Classification(class, strength)
   classification.class = class;
   classification.strength = strength;
end