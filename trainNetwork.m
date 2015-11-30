
cleanData = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);

nClasses = 6;
kFold = 10;
trainingFcn = 'trainrp';
filename = strcat(trainingFcn, '_Network_latest');

%returns optimal parameters over all folds 
OptimalParameters =  CrossValidateNN(x2, y2, kFold, trainingFcn);






bestMatrix = zeros(nClasses);
bestCRate = 0;

for i=1:100
    net = SetupNet(trainingFcn, OptimalParameters.layers, OptimalParameters.npl, x2, y2, (1:size(x2,2)), [], []);
    net = ConfigureTrainingParams(net, OptimalParameters, trainingFcn);
    trainedNet = train(net, x2, y2);
    matrix = ConfusionMatrix([cleanData.y, testANN(trainedNet, x2)], nClasses);
    classificationRate = sum(diag(matrix)) / sum(sum(matrix));
    if classificationRate > bestCRate
        bestMatrix = matrix;
        bestNet = trainedNet;
        bestCRate = classificationRate;
    end
end



classR = AnalyseMatrix(bestMatrix, nClasses);



save(filename);