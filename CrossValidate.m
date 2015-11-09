function [ ClassificationResults ] = CrossValidate( examples, labels, kFold)
       
    confusionMatrix = zeros(6);
    
    % generates indices for folds where each column is one test set
    indices = GenerateIndices(kFold, size(examples,1));
    
    for k = 1:kFold
        
        % split test and training indices
        test = indices(:,k);
        training = setdiff(indices,test);
        
        % remove zeros from indices
        test = test(test~=0);
        training = training(training~=0);
       
        trainingLabels = labels(training,:);
        trainingSet = examples(training,:);
        testSet = examples(test,:);
        actual = labels(test,:);


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