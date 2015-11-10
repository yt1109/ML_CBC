cleanData = load('cleandata_students.mat');
noisyData = load('noisydata_students.mat');

CleanClassificationResults = CrossValidate(cleanData.x, cleanData.y, 10);
NoisyClassificationResults = CrossValidate(noisyData.x, noisyData.y, 10);

%pruning_example(cleanData.x, cleanData.y);
%pruning_example(noisyData.x, noisyData.y);

% Create 6 binary targets
bTargets = cell(6);
for i = 1:6
    bTargets{i} = zeros(size(cleanData.y));
    for j = 1:size(cleanData.y)
        bTargets{i}(j) = cleanData.y(j) == i;
    end
end

% Train and draw a tree for each emotion

trees = cell(0);
for i=1:6
    targetVector = bTargets{i}(1:size(bTargets{i}, 1));
    trees{i} = Learning(cleanData.x, 1:1:45, targetVector);
    %DrawDecisionTree(trees{i});  
end

predictions = TestTrees(trees, cleanData.x);
%disp(predictions)
save('TrainedTrees.mat', 'trees')