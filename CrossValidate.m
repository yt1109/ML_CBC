function [ ClassificationResults ] = CrossValidate( examples, labels, kFold, nAttributes)
       
    confusionMatrix = zeros(nAttributes);
    
    % generates indices for folds where each column is one test set
    Indices = GenerateIndices(kFold, size(examples,1));
    
    for k = 1:kFold

        test = Indices.test{k};
        training = Indices.training{k};
       
        trainingLabels = labels(training,:);
        trainingSet = examples(training,:);
        testSet = examples(test,:);
        actual = labels(test,:);


        bTargets = cell(nAttributes);
        for i = 1:nAttributes
            bTargets{i} = zeros(size(trainingLabels));
            for j = 1:size(trainingLabels)
                bTargets{i}(j) = trainingLabels(j) == i;
            end
        end

        % Train and draw a tree for each emotion

        trees = cell(0);
        for i=1:nAttributes
            targetVector = bTargets{i}(1:size(bTargets{i}, 1));
            trees{i} = Learning(trainingSet, 1:1:45, targetVector); 
        end
       
        confusionMatrix = confusionMatrix + ConfusionMatrix([actual, TestTrees(trees, testSet)], nAttributes);
    end
    
    
    ClassificationResults = ClassifyMatrix(confusionMatrix, nAttributes);
    
end
