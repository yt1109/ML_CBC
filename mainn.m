cleanData = load('cleandata_students.mat');
noisyData = load('noisydata_students.mat');

nAttributes = 6;

CleanClassificationResults = CrossValidate(cleanData.x, cleanData.y, 10, nAttributes);
NoisyClassificationResults = CrossValidate(noisyData.x, noisyData.y, 10, nAttributes);

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

%save('TrainedTrees', trees);

predictions = TestTrees(trees, cleanData.x);
confusionMatrix = ConfusionMatrix([cleanData.y, predictions], nAttributes);
ClassificationResults = ClassifyMatrix(confusionMatrix, nAttributes);
%disp(predictions)