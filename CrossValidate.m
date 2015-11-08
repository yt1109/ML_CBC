function [ ClassificationResults ] = CrossValidate( examples, labels)
    
    % columns 1 - 2 are test indices
    % columns 3 - 4 & 5 - 6 are sets of examples indices
    % rows 1 - 10 are 10 unique partitions
    tenFold = load('10foldindices.mat');
    indices = tenFold.indices;
    
    confusionMatrix = zeros(6);
    
    for k = 1:10
        
        trainingLabels = labels([indices(k,3):indices(k,4) indices(k,5):indices(k,6)],:);
        trainingSet = examples([indices(k,3):indices(k,4) indices(k,5):indices(k,6)],:);
        testSet = examples(indices(k,1):indices(k,2),:);
        actual = labels(indices(k,1):indices(k,2),:);


        bTargets = cell(6);
        for i = 1:6
            bTargets{i} = zeros(size(trainingLabels));
            for j = 1:size(trainingLabels)
                bTargets{i}(j) = trainingLabels(j) == i;
            end
        end

        % Train and draw a tree for each emotion

        trees = cell(0);
        for i=1:6
            targetVector = bTargets{i}(1:size(bTargets{i}, 1));
            trees{i} = Learning(trainingSet, 1:1:45, targetVector);
            %DrawDecisionTree(trees{i});  
        end
       
        confusionMatrix = confusionMatrix + ConfusionMatrix([actual, TestTrees(trees, testSet)], 6);
    end
    
    
    for i=1:6
        ClassificationResults.recall(i, 1) = CalculateRecall(confusionMatrix(i,:), i);
        ClassificationResults.precision(i, 1) = CalculatePrecision(confusionMatrix(:,i), i);
        ClassificationResults.fMeasure(i, 1) = CalculateFMeasure(ClassificationResults.precision(i, 1), ClassificationResults.recall(i, 1), 1); 
    end
    
    ClassificationResults.rate = CalculateRate(confusionMatrix);
    
end

function [recall] = CalculateRecall(row, class)
    recall = row(1, class) / sum(row);
end

function [precision] = CalculatePrecision(column, class)
    precision = column(class, 1) / sum(column);
end

function [classificationRate] = CalculateRate(matrix)
    classificationRate = sum(diag(matrix)) / sum(sum(matrix));
end

function [fMeasure] = CalculateFMeasure(precision, recall, a)
    fMeasure = (1 + a ^ 2) * (precision * recall/ (precision + recall));
end