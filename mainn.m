cleanData = load('cleandata_students.mat');

CrossValidate(cleandata.x, cleandata.y)

% Create 6 binary targets
bTargets = cell(6);
for i = 1:6
    bTargets{i} = zeros(size(cleanData.y));
    for j = 1:size(cleanData.y)
        bTargets{i}(j) = cleanData.y(j) == i;
    end
end

% Train and draw a tree for each emotion

trees = cell(1, 6);
for i=1:6
    targetVector = bTargets{i}(1:size(bTargets{i}, 1));
    trees{i} = Learning(cleanData.x, 1:1:45, targetVector);
    DrawDecisionTree(trees{i});
    
end

%save('TrainedTrees', trees);