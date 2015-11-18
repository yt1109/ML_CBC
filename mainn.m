cleanData = load('cleandata_students.mat');
noisyData = load('noisydata_students.mat');

nAttributes = 6;

CleanClassificationResults = CrossValidateTrees(cleanData.x, cleanData.y, 10, nAttributes);
NoisyClassificationResults = CrossValidateTrees(noisyData.x, noisyData.y, 10, nAttributes);

%pruning_example(cleanData.x, cleanData.y);
%pruning_example(noisyData.x, noisyData.y);

% Create 6 binary targets
bTargets = cell(nAttributes);
for i = 1:nAttributes
    bTargets{i} = zeros(size(cleanData.y));
    for j = 1:size(cleanData.y)
        bTargets{i}(j) = cleanData.y(j) == i;
    end
end

% Train and draw a tree for each emotion

trees = cell(0);
for i=1:nAttributes
    targetVector = bTargets{i}(1:size(bTargets{i}, 1));
    trees{i} = Learning(cleanData.x, 1:1:45, targetVector);
    %DrawDecisionTree(trees{i});  
end

predictions = TestTrees(trees, cleanData.x);
confusionMatrix = ConfusionMatrix([cleanData.y, predictions], nAttributes);
normalisedMatrix = NormaliseMatrix(confusionMatrix);
ClassificationResults.regular = AnalyseMatrix(confusionMatrix, nAttributes);
ClassificationResults.normalised = AnalyseMatrix(normalisedMatrix, nAttributes);
    
%disp(predictions)

save('TrainedTrees.mat', 'trees')
